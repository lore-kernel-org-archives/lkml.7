Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F73C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2140206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573604588;
	bh=p21HfG9PuTDP6yzK41NOJ/x8hi3UaE2AKs0mQdGDFTc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=10OqyQB4TrMJu5u2CX+UDlUTojBgrrEDzF33xc1a5zw+Pew+F66GB8kzU9dojKTWF
	 KxQYfNR8MSGf2KCd3AQIeqFiG9tQyqui1ecJufSIS/nOoyUsGa7P8IoVSTaHFBSVcS
	 yqsdfr3SKG8jN63Unz8QtOjxpm3JwttUMwFSdVv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKMAXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKMAXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:23:06 -0500
Received: from paulmck-ThinkPad-P72.home (mobile-166-137-177-111.mycingular.net [166.137.177.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD65206BB;
        Wed, 13 Nov 2019 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573604584;
        bh=p21HfG9PuTDP6yzK41NOJ/x8hi3UaE2AKs0mQdGDFTc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QoLO6MH810hGQsYXV7D2m3NCqrXUHHsOGMW1+CXPccXjqHiZ3dKwnrV+huQjjUVKv
         lxoSdD4LkF3p55rBcLELlhO6By/U/RW8FjknWhci860WQulTUuY4e42vJSa/w0ykI1
         jp+a+CglVtIylC3Hhdz1G4Cq8mlqMzWSwxMxZgaI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8558035227E6; Tue, 12 Nov 2019 16:23:03 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:23:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.11.11a 61/63] htmldocs: include/linux/list.h:901:
 warning: Function parameter or member 'h' not described in 'hlist_fake'
Message-ID: <20191113002303.GX2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <201911122338.Rg2VoMVx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911122338.Rg2VoMVx%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:47:48PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.11.11a
> head:   f0869ca19ae27140ba1f11040184a5c5813c396b
> commit: 49c246c3a06b981a75633e61fd5b334b4c96e270 [61/63] rcu: Add and update docbook header comments in list.h
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Good catch, fixed!

							Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
>    include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
>    include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
>    include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
>    include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
>    drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
>    drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
>    drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL5' not described in enum 'intel_dpll_id'
>    drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL6' not described in enum 'intel_dpll_id'
>    drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL5' description in 'intel_dpll_id'
>    drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL6' description in 'intel_dpll_id'
>    drivers/gpu/drm/i915/display/intel_dpll_mgr.h:342: warning: Function parameter or member 'wakeref' not described in 'intel_shared_dpll'
>    Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
>    Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
>    Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
>    drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
>    drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
>    drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
>    drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
>    drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
>    drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
>    drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pinned_ctx' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id_mask' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_check_timer' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_wq' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pollin' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'periodic' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'period_exponent' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'oa_buffer' not described in 'i915_perf_stream'
>    drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
>    drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
>    drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
>    drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
>    drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
>    drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
>    drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
>    drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
>    drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
>    drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
>    drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
>    drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
>    drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
>    drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
>    drivers/gpu/drm/mcde/mcde_drv.c:1: warning: 'ST-Ericsson MCDE DRM Driver' not found
>    include/net/mac80211.h:2018: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file include/linux/reservation.h
>    Error: Cannot open file include/linux/reservation.h
>    lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
>    lib/genalloc.c:1: warning: 'gen_pool_free' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
> >> include/linux/list.h:901: warning: Function parameter or member 'h' not described in 'hlist_fake'
>    include/linux/list.h:901: warning: Excess function parameter 'n' description in 'hlist_fake'
>    include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
>    mm/util.c:1: warning: 'get_user_pages_fast' not found
>    mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2823: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source gpu_info FW provided soc bounding box struct or 0 if not
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'soc_bounding_box' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_pflip_high_irq' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_crtc_high_irq' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'register_hpd_handlers' not found
>    include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
>    include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
>    include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
>    include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv' not described in 'drm_gem_shmem_object'
>    include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv_list' not described in 'drm_gem_shmem_object'
>    include/net/cfg80211.h:1185: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
>    include/net/mac80211.h:4056: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
>    Documentation/hwmon/inspur-ipsps1.rst:2: WARNING: Title underline too short.
> 
> vim +901 include/linux/list.h
> 
> 756acc2d61712a Al Viro          2010-10-23  894  
> 49c246c3a06b98 Paul E. McKenney 2019-11-09  895  /**
> 49c246c3a06b98 Paul E. McKenney 2019-11-09  896   * hlist_fake: Is this node a fake hlist?
> 49c246c3a06b98 Paul E. McKenney 2019-11-09  897   * @n: Node to check for being a self-referential fake hlist.
> 49c246c3a06b98 Paul E. McKenney 2019-11-09  898   */
> cbedaac63481de Josef Bacik      2015-03-12  899  static inline bool hlist_fake(struct hlist_node *h)
> cbedaac63481de Josef Bacik      2015-03-12  900  {
> cbedaac63481de Josef Bacik      2015-03-12 @901  	return h->pprev == &h->next;
> cbedaac63481de Josef Bacik      2015-03-12  902  }
> cbedaac63481de Josef Bacik      2015-03-12  903  
> 
> :::::: The code at line 901 was first introduced by commit
> :::::: cbedaac63481dea52327127a9f1c60f092bd6b07 inode: add hlist_fake to avoid the inode hash lock in evict
> 
> :::::: TO: Josef Bacik <jbacik@fb.com>
> :::::: CC: Josef Bacik <jbacik@fb.com>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


