/**
 * ===============================================================
 * File Name   : LT_CommonBaseHelper.js
 * Description : FrameWork 공통 helper javascript
 : 공통업무 비즈 로직을 구현
 * Author      : i2max
 * Modification Log
 * ===============================================================
 * Ver  Date          Author         Modification
 * ===============================================================
 * 1.0  2016. 07. 10  i2max        Create
 * ===============================================================
 */
({
    /*
     * ============================================================================
     * 공통 객체 변수 / 함수 정의
     * ============================================================================
     */
    /**
     * <pre>
     * console loggin 여부
     * </pre>
     */
    g_isLogging : null,
    /**
     * <pre>
     * console debug 시 logPrefix 변수
     * </pre>
     */
    g_logPrefix : "LT_CommonBaseHelper : ",
    /**
     * <pre>
     * 공통 lighting spinner attribute name
     * </pre>
     */
    g_lightningSpinner : "v.IsShowSpinner",
    /**
     * <pre>
     * spinner show / hide set function
     * </pre>
     * @param componetn
     * @param event
     * @param isShowHide : true(show), false(hide)
     */
    gfn_showHideLightningSpinner : function(component, event, isShowHide) {
        if(isShowHide === true || isShowHide === false) {
            component.set('v.IsShowSpinner', isShowHide);
        }
        else {
            this.gfn_toggleSpinner(component, event);
        }
        return;
    },
    /**
     * <pre>
     * spinner show / hide toggle function
     * </pre>
     * @param component
     * @param event
     */
    gfn_toggleLightningSpinner : function(component, event) {
        var isShow = component.get(this.g_lightningSpinner);
        component.set(this.g_lightningSpinner, !isShow);
    },
    /**
     * <pre>
     * 공통 Server Action Response 처리 callback 함수 객체
     * callback의 response의 state를 key 로 함수를 정의
     * callback에서 바로 helper this를 사용할 수 없기 때문에 직접 구현을 한다.
     * </pre>
     */
    commonCallbacks : function(){
        var _this = this;
        return {
            "SUCCESS" : function(response) {
            },
            "INCOMPLETE" : function(response) {
            },
            "ABORTED" : function(response) {
            },
            "REFRESH" : function(response) {
            },
            "ERROR" : function(response) {
                var errors = response.getError();
                var showErrorMessages = [];
	
	            _this.getLogger().dir(errors);
	            _this.getLogger().log('errors.length', errors.length);
	
	            if (errors) {

		            _this.getLogger().log('-- Action Info[Start] --');
		            _this.getLogger().log(response.getName());
		            _this.getLogger().log(response.getParams());
		            _this.getLogger().log('-- Action Info[end] --');
		
		            for(var i=0; i<errors.length; i++){
                        //-------------------------------------------------
                        // System Error 인 경우 : Internal Server Error
                        //-------------------------------------------------
                        if (errors[i].message) {
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                            _this.getLogger().error("System Error message: " + errors[i].message);
                            showErrorMessages.push('Server Error occurred..');
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                        }
                        //-------------------------------------------------
                        // DML Error 인 경우 : pageErrors
                        //-------------------------------------------------
                        else if(errors[i].pageErrors) {
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                            var e1 = errors[i];
                            for(var j=0; j<e1.length; j++){
                                _this.getLogger().error("pageErrors Error message: " + e1[j].message);
                                showErrorMessages.push(e1.message);
                            }
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                        }
                        //-------------------------------------------------
                        // DML Error 인 경우 : fieldErrors
                        //-------------------------------------------------
                        else if(errors[i].fieldErrors) {
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                            var e1 = errors[i];
                            for(var k=0; k<e1.length; k++){
                                _this.getLogger().error("fieldErrors Error message: " + e1[k].message);
                                showErrorMessages.push('Server Error occurred..');
                            }
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                        }
                        else {
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                            _this.getLogger().error("Unknown error");
                            showErrorMessages.push("Unknown error occurred...");
                            _this.getLogger().log('[' + _this.g_logPrefix + '] ▶▶▶ FW Log : Error Message ◀◀◀');
                        }
                    }

                    // toast 로 간단하게 에러를 알려준다.
                    try {
	                    var _params = {
		                    mode: 'sticky',
		                    type: 'error',
		                    message: showErrorMessages.join('<br/>')
	                    };
	                    _this.gfnForceEventUtil.showToast(_this,_params);
                    }
	                catch(e) {}
                }
            }
        }
    },
    /**
     * <pre>
     * 공통 Server Action Response 처리 함수
     * </pre>
     * @param response : Server response data
     * @param component
     * @param event
     * @param callbacks : 사용자 정이 callbacks 함수 객체
     */
    gfn_handleResponse : function(response, component, event, callbacks) {
        var _callbacks = this.gfnUtil.extend(this.commonCallbacks(), callbacks);
        var state = response.getState();
	    var _this = this;
	    
	    try {
		    _this.getLogger().log("♣♣♣ component name : " + component.getName());
        } catch(e){}
	    
        try {
            if(component.isValid()) {
                //_callbacks[state].call(null, response);
                //-----------------------------------------------------------
                // this를 파라미터르 넘김
                // callback 함수에서 helper 대신 this 사용 가능
                //-----------------------------------------------------------
                _callbacks[state].call(this, response);
            }
            else {
                // to-do : component is inValid
            }
        }
        catch(e) {
            throw e;
        }
        finally {
            this.gfn_showHideLightningSpinner(component, event, false);
        }
    },
    /**
     * <pre>
     * Server Contoller 호출 Keys Object
     * </pre>
     */
    g_transKeys : {
        "SC_NAME_KEY"       : "controllerName"
        ,   "SC_PARAMS_KEY"     : "params"
        ,   "SC_CALLBACKS_KEY"  : "callbacks"
        ,   "SC_OPTIONS_KEY"    : "options"
    },
    /**
     * <pre>
     * 별도 global 옵션
     * </pre>
     */
    g_options : {
        "isStorable" : false            // action의 client storable 여부
        ,   "isBackground" : false          // enqueue 의 background 수행 여부
    },
    /**
     * <pre>
     * Server Contoller 호출 Service 함수
     * 파라미터를 순서적으로 넘겨서 처리
     * g_transKeys 의 value값을 key로 문자열 그대로 세팅
     * </pre>
     * @param component
     * @param event
     * @param helper
     * @param scArguments : Server Controller arguments
     */
    gfn_scServiceN : function(component, event, helper, controllerName, params, callbacks, options) {
        this.gfn_scService(component, event, helper, {
            "controllerName" : controllerName
            , "params" : params
            , "callbacks" : callbacks
            , "options" : options
        });
    },
    /**
     * <pre>
     * Server Contoller 호출 Service 함수
     * 파라미터를 Object에 넘겨서 처리
     * </pre>
     * @param component
     * @param event
     * @param helper
     * @param scArguments : Server Controller arguments
     */
    gfn_scService : function(component, event, helper, scArguments) {
        //=====================================================================
        // Update the items via a server-side action
        // Server Class의 action Method 호출
        //=====================================================================
        var action = component.get(scArguments[this.g_transKeys["SC_NAME_KEY"]]);
        //----------------------------------------------------------------------
        // params 의 key 와 cls의 호출 함수의 parameter의 name과 동일해야 함.
        // pMap은 공통 서버 Controller 호출 argument 명으로 사용함.
        //----------------------------------------------------------------------
        this.getLogger().log('[' + this.g_logPrefix + '] ▶▶▶ FW Log : Request Params ◀◀◀');
        var _params = scArguments[this.g_transKeys["SC_PARAMS_KEY"]] || {};
        this.getLogger().dir(_params);
        this.getLogger().log('[' + this.g_logPrefix + '] ▶▶▶ FW Log : Request Params ◀◀◀');
        action.setParams({"pmap" : _params});
        //=====================================================================
        // 별도 options 세팅
        //=====================================================================
        var _options = this.gfnUtil.extend(this.g_options, (scArguments[this.g_transKeys["SC_OPTIONS_KEY"]] || {}));
        //=====================================================================
        // action storable 세팅
        // 무조건 storable 하면 안되고 idempotent and non-mutating 한 action만 저장
        // [매우 중요하므로 신중하게 처리할 것] : 주로 공통단만 사용할 것
        //=====================================================================
        var _isStorable = _options["isStorable"] || false;
        if(_isStorable)  action.setStorable();
        //=====================================================================
        // callback 세팅
        //=====================================================================
        var self = this;
        action.setCallback(this, function(response) {
            self.getLogger().log('[' + this.g_logPrefix + '] ▶▶▶ FW Log : response data ◀◀◀');
            self.getLogger().log(response);
            self.getLogger().dir(response);
            self.getLogger().log('[' + this.g_logPrefix + '] ▶▶▶ FW Log : response data ◀◀◀');
            self.gfn_handleResponse(response, component, event, scArguments[this.g_transKeys["SC_CALLBACKS_KEY"]]);
        });

        //=====================================================================
        // spinner show
        //=====================================================================
        this.gfn_showHideLightningSpinner(component, event, true);
        //=====================================================================
        // Queue에 정의된 action을 추가하여 실행
        //=====================================================================
        var _isBackground = _options["isBackground"] || false;
        //$A.enqueueAction(action, _isBackground);
        if(_isBackground) action.setBackground();
        $A.enqueueAction(action);
    },
    /**
     * <pre>
     * 서버 리턴 데이터를 반환
     * LT_DATA KEY를 서버에서 사용
     * </pre>
     * @param response : Server response data
     */
    gfn_parseServerData : function(response) {
        return response.getReturnValue().LT_DATA;
    },
    /**
     * <pre>
     * 서버 리턴 Biz Error 데이터를 반환
     * LT_ERROR KEY를 서버에서 사용
     * </pre>
     * @param response : Server response data
     */
    gfn_parseServerBizError : function(response) {
        return response.getReturnValue().LT_ERROR;
    },
    /**
     * <pre>
     * 서버 리턴 Biz Error 데이터중 에러여부 반환
     * </pre>
     * @param response : Server response data
     */
    gfn_isBizError : function(response) {
        var _LT_ERROR = this.gfn_parseServerBizError(response);
        return _LT_ERROR ? _LT_ERROR.isBizError : false;
    },
    /**
     * <pre>
     * 서버 리턴 Biz Error 데이터중 에러메시지 반환
     * </pre>
     * @param response : Server response data
     */
    gfn_bizErrorMessage : function(response) {
        var _LT_ERROR = this.gfn_parseServerBizError(response);
        return _LT_ERROR ? _LT_ERROR.bizErrorMessage : '';
    },
    /**
     * <pre>
     * 각 컴포넌트의 label map을 구성하기 위한 함수
     * </pre>
     */
    gfn_getLabels : function(component, event, helper) {
        helper.getLogger().log('--- LT_CommonBaseHelper : gfn_getLabels ---');
        var labelKeys = component.get("v.labelKeys");
        var sobjectKeys = labelKeys.sobjectKeys;
        var hasFieldResult = labelKeys.hasFieldResult;

        if(sobjectKeys && sobjectKeys.length > 0) {
            this.gfn_getSObjectLabels(component, event, helper, sobjectKeys, hasFieldResult);
        }
    },
    /**
     * <pre>
     * sobject의 field label을 구함. controller 호출을 통한 구성
     * </pre>
     */
    gfn_getSObjectLabels : function(component, event, helper, sobjectKeys, hasFieldResult) {
        helper.getLogger().log('--- LT_CommonBaseHelper : gfn_getSObjectLabels ---');
        var params = {"sobjectKeys" : sobjectKeys, "hasFieldResult" : hasFieldResult};
        var options = {
            'isBackground' : true
        };
        var callbacks = {
            "SUCCESS" : function(response) {
                var LT_DATA = helper.gfn_parseServerData(response);
                this.getLogger().log('▶▶▶ labels ◀◀◀');
                this.getLogger().dir(LT_DATA);
                this.getLogger().log('▶▶▶ labels ◀◀◀');
                var sobjectLabels = {"sobject" : LT_DATA};

                //=====================================================================
                // 최종적으로 label 세팅
                //=====================================================================
                component.set("v.labels", sobjectLabels);
            }
        }
        this.gfn_scServiceN(component, event, helper, "c.getLabels", params, callbacks, options);
    },
    /**
     * <pre>
     * global sldsClassMap
     * Deprecated : class 매핑은 없음
     * </pre>
     */
    g_sldsClassMap : {
        'header' : 'slds-page-header'
        ,'header_title' : 'slds-page-header__title slds-truncate slds-align-middle'
        ,'form_div1' : 'slds-grid slds-media_responsive'
        ,'form_div2' : 'slds-has-flexi-truncate slds-p-horizontal_x-small'
        ,'form_label' : 'slds-form-element__label slds-no-flex'
        ,'form_div1_center' : 'slds-grid slds-media_responsive slds-grid_align-center'
        ,'form_div1_right':'slds-grid slds-media_responsive slds-grid_align-end'
        ,'box' : 'slds-box'
        ,'box_small' : 'slds-box slds-box_small'
        ,'float_left' : 'slds-float_left'
        ,'float_right' : 'slds-float_right'
        ,'align_center' : 'slds-align_absolute-center'
        ,'align_top' : 'slds-align-top'
        ,'align_mid' : 'slds-align-middle'
        ,'align_bot' : 'slds-align-bottom'
        ,'table_simple' : 'slds-table slds-table_bordered'
        ,'table_thead' : ''
        ,'table_thead_tr' : 'slds-text-title_caps'
        ,'table_thead_th' : ''
        ,'table_thead_th_div' : 'slds-truncate'
        ,'table_tbody_tr' : ''
        ,'table_tbody_td' : ''
        ,'table_tbody_td_div' : 'slds-truncate'
    },
	
/*
 * ============================================================================
 * DataTable 관련 Helper 함수
 * ============================================================================
 */
	
	/**
	 * checkBoxAll onChange handler
	 */
	gfn_ClearCheckedAll : function(component, event, helper, checkBoxAll) {
		if($A.util.isEmpty(checkBoxAll) === false) {
			checkBoxAll.set('v.checked', false);
		}
	},
	
	/**
	 * checkBoxAll onChange handler
	 */
	gfn_ChangeAllChecked : function(component, event, helper, checkedMap, checkBoxAll, checkBoxItems) {
		var checked = checkBoxAll.get('v.checked');
		var val;
		var checkBox;
		if($A.util.isEmpty(checkBoxItems) === false) {
			checkBoxItems = Array.isArray(checkBoxItems) ? checkBoxItems : [checkBoxItems];
			for(var i=0,len=checkBoxItems.length; i<len; i++) {
				checkBox = checkBoxItems[i];
				checkBox.set('v.checked', checked);
				val = checkBox.get('v.value');
				checked ? (checkedMap[val] = val) : delete checkedMap[val];
			}
		}
	},
	
	/**
	 * checkBoxItem onChange Handler
	 */
	gfn_ChangeChecked : function(component, event, helper, checkedMap, checkBox, checkBoxAll) {
		var checked = checkBox.get('v.checked');
		var val = checkBox.get('v.value');
		if(checked === true) {
			checkedMap[val] = val;
		}
		else {
			// 항목에서 지움
			delete checkedMap[val];
			// checkBoxAll을 clear
			if($A.util.isEmpty(checkBoxAll) === false) {
				checkBoxAll.set('v.checked', false);
			}
		}
	},
	
	/**
	 * set querystirng to compoentn attribute
     * param component : 대상 컴포넌트
     * param attrs : 대상 컴포넌트의 할당 어트리뷰트 스트링 리스트
	 */
	gfn_SetAttrFromQueryString : function(component, attrs) {
        var self = this;
	    var settingAttrs = attrs.split(';');
		var urlObj = this.gfn_GetParams();
		var tmp;
		
		for(var i=0, len=settingAttrs.length; i<len; i++) {
		    tmp = settingAttrs[i];
			component.set('v.'+tmp, urlObj.get(tmp));
			self.getLogger().log(tmp + ' : ' + component.get('v.'+ tmp));
        }
	},
	
	/**
	 * get querystirng
	 */
	gfn_GetParams : function() {
		var self = this;
		var urlParams = decodeURIComponent(window.location.search.substring(1)).split('&');
		var urlObj = {};
		
		self.getLogger().log(urlParams);
		
		for(var i=0, len=urlParams.length; i<len; i++){
			var param = urlParams[i].split('=');
			urlObj[param[0]] = param[1];
			self.getLogger().log(urlObj);
		}
		return urlObj;
	},
    
    /*
     * ============================================================================
     * Utility
     * ============================================================================
     */
    gfnUtil : {
        /**
         * <pre>
         * 객체 Merge
         * 새로운 객체에 obj, src를 모두 merge하여 리턴한다.
         * ex) var obj = {}, src = {};
         *       obj = helper.gfnUtil.extend(obj, src);
         * </pre>
         * @param obj : target객체
         * @param src : source객체
         */
        extend: function(obj, src) {
            var targetObj = {};
            for(var key in obj){
                if (obj.hasOwnProperty(key)) {
                    targetObj[key] = obj[key];
                }
            }
            for(var key in src){
                if (src.hasOwnProperty(key)) {
                    targetObj[key] = src[key];
                }
            }
            return targetObj;
        },
        /**
         * <pre>
         * 문자열의 {0}, {1} .. 등을 대체하여 format
         * ex) var tmp = helper.gfnUtil.stringFormat('{0}, {1}', 'hello', 'world');
         * </pre>
         */
        stringFormat: function() {
            var theString = arguments[0];
            for (var i = 1, len = arguments.length; i < len; i++) {
                var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
                theString = theString.replace(regEx, arguments[i]);
            }
            return theString;
        },
        /**
         * <pre>
         * Renderer(afterRender)에서 aura_class 이름과 css class을 맵에 담아 사용
         * aura_class 마다 css 적용
         * ex)helper.gfnUtil.classSet(cmp);
         * </pre>
         */
        setSldsClass: function(cmp, helper) {
            //--------------------------------------------------------
            // LT_CommonIntf 에서 설정된 isSetSldsClass의 값 설정참조
            //--------------------------------------------------------
            var isSetSldsClass = cmp.get('v.isSetSldsClass') || true;
            if(isSetSldsClass) {
                var eles = cmp.getElements();
                if(eles) {
                    for(var i=0; i<eles.length; i++){
                        // 최상위
                        if (helper.g_sldsClassMap.hasOwnProperty(eles[i].slds_class)) {
                            eles[i].setAttribute('class', (eles[i].getAttribute('class') || '' ) +
                                ' ' + helper.g_sldsClassMap[el.slds_class]);
                        }
                        //최상위들의 모든 자식/후손들
                        if (eles[i].childElementCount) {
                            var childEls = eles[i].querySelectorAll('*');
                            for(var j=0; j<childEls.length; j++){
                                if (helper.g_sldsClassMap.hasOwnProperty(childEls[j].slds_class)) {
                                    childEl.setAttribute('class', (childEls[j].getAttribute('class') || '') + ' ' + helper.g_sldsClassMap[childEls[j].slds_class]);
                                }
                            }
                        }
                    }
                }
            }
        },
        /**
         * <pre>
         * 업무 컴포넌트 Renderer에서 사용할 것
         * 랜더 후 auraId에 'touchend' 이벤트 리스너 등록/ action evtName 이벤트 발생
         * 이벤트 등록 및 핸들러 필요
         * scroller: <ui:scrollerWrapper>
         * scroll.scrollTop: 스크롤 내려온 높이
         * scroll.scrollHeight: 전체 스크롤 높이
         * window.innerHeight: 모바일 기기 높이
         * ex) helper.gfnUtil.setMobileScroll(component, helper, 'scroller','LT_CommonScrollEvt');
         * FormFactorRenderer.js 참조
         * </pre>
         */
        setMobileScroll: function(component, helper, auraId, evtName) {
            if (!component.get('v.IsDesktop')) {
                var scroller = component.find(auraId);
                if (scroller && scroller.getElements().length > 0) {
                    var scroll = scroller.getElements()[0];
                    //=====================================================================
                    // touchstart 이벤트 등록
                    //=====================================================================
                    scroll.addEventListener('touchstart', function(e) {
                        //helper.getLogger().log('>>>> touchstart', scroll.scrollHeight, e.changedTouches[0].pageY, e.changedTouches[0].screenY, (e.changedTouches[0].screenY-e.changedTouches[0].pageY));
                        //=====================================================================
                        // touchStart 시작 포인트를 세팅
                        //=====================================================================
                        scroller.set('v.touchStart', e.changedTouches[0].pageY);
                        //=====================================================================
                        // 최초 scroll offset size를 세팅
                        //=====================================================================
                        if(scroller.get('v.scrollOffsetSize') == 0) {
                            scroller.set('v.scrollOffsetSize', scroll.scrollHeight/2);
                        }
                    });
                    //=====================================================================
                    // touchend 이벤트 등록
                    //=====================================================================
                    scroll.addEventListener('touchend', function(e) {
                        //helper.getLogger().log('>>>> touchend', scroll.scrollHeight, e.changedTouches[0].pageY, e.changedTouches[0].screenY, (e.changedTouches[0].screenY-e.changedTouches[0].pageY));
                        //=====================================================================
                        // scroll up / down을 판단하여 거래 허용
                        //=====================================================================
                        if (scroller.get('v.touchStart') > e.changedTouches[0].pageY) {
                            //=====================================================================
                            // 최초 scroll offset size와 비교하여 거래발생을 허용
                            //=====================================================================
                            if((scroller.get('v.touchStart')-e.changedTouches[0].pageY) > scroller.get('v.scrollOffsetSize')) {
                                component.getEvent(evtName).fire();
                            }
                        }
                    });
                }
            }
        }
    },
    /**
     * <pre>
     * force event 를 Util로 모아서 공통 처리
     * Deprecated : option 사용법을 알아야 하기에 Util 불필요
     * </pre>
     */
    gfnForceEventUtil : {
        paramsSetting : function(helper, params) {
            return helper.gfnUtil.extend({}, params);
        },
        createRecord : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:createRecord").setParams(_params).fire();
        },
        editRecord : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:editRecord").setParams(_params).fire();
        },
        navigateToComponent : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToComponent").setParams(_params).fire();
        },
        navigateToList : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToList").setParams(_params).fire();
        },
        navigateToObjectHome : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToObjectHome").setParams(_params).fire();
        },
        navigateToRelatedList : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToRelatedList").setParams(_params).fire();
        },
        navigateToSObject : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToSObject").setParams(_params).fire();
        },
        navigateToURL : function(helper, params) {
            var _params = helper.gfnForceEventUtil.paramsSetting(helper, params);
            $A.get("e.force:navigateToURL").setParams(_params).fire();
        },
        recordSave : function(helper, targetComp) {
            targetComp.get("e.recordSave").fire();
        },
        refreshView : function() {
            $A.get("e.force:refreshView").fire();
        },
        showToast : function(helper, params) {
            var _params = helper.gfnUtil.extend({mode: 'sticky'}, (params || {}));
            $A.get("e.force:showToast").setParams(_params).fire();
        }
    },
    /**
     * <pre>
     * 내부 사용 logger
     * </pre>
     */
    logger : null,
    /**
     * <pre>
     * Logger instance create
     * </pre>
     */
    getLogger : function(){
        var _this = this;
        _this.logger = _this.logger || {
            log : function() {
                if(console && _this.g_isLogging) {
                    console.log.apply(console, Array.prototype.slice.call(arguments));
                }
            },
            dir : function() {
                if(console && _this.g_isLogging) {
                    console.dir.apply(console, Array.prototype.slice.call(arguments));
                }
            },
            error : function() {
                if(console && _this.g_isLogging) {
                    console.error.apply(console, Array.prototype.slice.call(arguments));
                }
            }
        };
        return _this.logger
    },
    /**
     * <pre>
     * 동적으로 Component를 생성 할 때 공통 에러 처리
     * </pre>
     */
    gfn_handleError : function(status, errorMessage) {
        var _this = this;
        if(status === "INCOMPLETE"){
            _this.getLogger().log('No response from server or client is offline.');
        } else if(status === "ERROR") {
            _this.getLogger().log('Error :' + errorMessage);
        }
    },
	/**
	 * <pre>
	 * Data Record 조회시 2000건이 넘을 경우 show toast
	 * </pre>
	 */
	gfn_showToastHasMoreRecordOver2000 : function(hasMoreRecordOver2000) {
		if(hasMoreRecordOver2000 === true) {
			var resultsToast = $A.get("e.force:showToast");
			resultsToast.setParams({
				"type": "info",
				"title": "Result Records",
				"message": "has more records over 2000"
			});
			$A.get("e.force:closeQuickAction").fire();
			resultsToast.fire();
		}
	},
	
})