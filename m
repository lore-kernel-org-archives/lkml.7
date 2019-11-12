Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB77C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE712067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKLPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:48:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:48373 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLPsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:48:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 07:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; 
   d="gz'50?scan'50,208,50";a="405637785"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2019 07:48:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iUYP3-0000IL-RD; Tue, 12 Nov 2019 23:48:25 +0800
Date:   Tue, 12 Nov 2019 23:47:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2019.11.11a 61/63] htmldocs: include/linux/list.h:901:
 warning: Function parameter or member 'h' not described in 'hlist_fake'
Message-ID: <201911122338.Rg2VoMVx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="osvumc7gcz2dfrcq"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osvumc7gcz2dfrcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.11.11a
head:   f0869ca19ae27140ba1f11040184a5c5813c396b
commit: 49c246c3a06b981a75633e61fd5b334b4c96e270 [61/63] rcu: Add and update docbook header comments in list.h
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL5' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL6' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL5' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL6' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:342: warning: Function parameter or member 'wakeref' not described in 'intel_shared_dpll'
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pinned_ctx' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id_mask' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_check_timer' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_wq' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pollin' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'periodic' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'period_exponent' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'oa_buffer' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/mcde/mcde_drv.c:1: warning: 'ST-Ericsson MCDE DRM Driver' not found
   include/net/mac80211.h:2018: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
>> include/linux/list.h:901: warning: Function parameter or member 'h' not described in 'hlist_fake'
   include/linux/list.h:901: warning: Excess function parameter 'n' description in 'hlist_fake'
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2823: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source gpu_info FW provided soc bounding box struct or 0 if not
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'soc_bounding_box' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_pflip_high_irq' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_crtc_high_irq' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'register_hpd_handlers' not found
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv' not described in 'drm_gem_shmem_object'
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv_list' not described in 'drm_gem_shmem_object'
   include/net/cfg80211.h:1185: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
   include/net/mac80211.h:4056: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
   Documentation/hwmon/inspur-ipsps1.rst:2: WARNING: Title underline too short.

vim +901 include/linux/list.h

756acc2d61712a Al Viro          2010-10-23  894  
49c246c3a06b98 Paul E. McKenney 2019-11-09  895  /**
49c246c3a06b98 Paul E. McKenney 2019-11-09  896   * hlist_fake: Is this node a fake hlist?
49c246c3a06b98 Paul E. McKenney 2019-11-09  897   * @n: Node to check for being a self-referential fake hlist.
49c246c3a06b98 Paul E. McKenney 2019-11-09  898   */
cbedaac63481de Josef Bacik      2015-03-12  899  static inline bool hlist_fake(struct hlist_node *h)
cbedaac63481de Josef Bacik      2015-03-12  900  {
cbedaac63481de Josef Bacik      2015-03-12 @901  	return h->pprev == &h->next;
cbedaac63481de Josef Bacik      2015-03-12  902  }
cbedaac63481de Josef Bacik      2015-03-12  903  

:::::: The code at line 901 was first introduced by commit
:::::: cbedaac63481dea52327127a9f1c60f092bd6b07 inode: add hlist_fake to avoid the inode hash lock in evict

:::::: TO: Josef Bacik <jbacik@fb.com>
:::::: CC: Josef Bacik <jbacik@fb.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--osvumc7gcz2dfrcq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--osvumc7gcz2dfrcq--
