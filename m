Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F217C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FE421655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569337337;
	bh=QMgJORPCEe45dbWla/cKE5rqnESJgYjO5D24uofcrxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dI2dzC+6Qa5UaPUeH9sU4/NNztLJ0ZKnVL5EAN+SxsTNEpbfdtQV5W8zVS6guV+oE
	 Gs+VT6FoYe4zfXRHdOnptesSLEKf/XuNhNMdCwTUOyTklLkpGf4OA1/2MdXvHMPbcz
	 BvyuatokPLNaOi6PdwyCNJPJcDB+9+LJCY9PJ8ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409842AbfIXPCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409761AbfIXPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:01:24 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F41B214DA;
        Tue, 24 Sep 2019 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569337283;
        bh=QMgJORPCEe45dbWla/cKE5rqnESJgYjO5D24uofcrxQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cZbx/VG1ivhOQa3JjDAS56PdhUm8mCSh4IPFFvk/DLSEdObzqSzNy9Gub93N6pKHc
         cAVeKBs7ITvTOSkgprLZy10wfl9QBV58YwCBfTDXRQwucptcTT5SqelNnkV0hSZiVl
         HMHd2KWPO4DtKwtmuVA/eLFW/H5i1kuvu4loIVFQ=
Date:   Tue, 24 Sep 2019 08:01:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.09.23a 61/77] htmldocs: kernel/rcu/tree.c:2706:
 warning: Function parameter or member 'krcp' not described in
 'kfree_rcu_cpu_work'
Message-ID: <20190924150120.GB2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <201909241021.mW1BN9Yl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909241021.mW1BN9Yl%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:24:24AM +0800, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> head:   97de53b94582c208ee239178b208b8e8b9472585
> commit: 3cc794ad18bfc6e46d58411b53f2784388d5bb85 [61/77] rcu: Add multiple in-flight batches of kfree_rcu() work
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
>    WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>    include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
>    include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
>    include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
>    include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
>    fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
>    fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
>    fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
>    fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
>    fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
>    mm/util.c:1: warning: 'get_user_pages_fast' not found
>    mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
>    drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
>    drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
>    drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
>    drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
>    include/linux/w1.h:272: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
>    include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
>    include/linux/mod_devicetable.h:822: warning: Function parameter or member 'context' not described in 'wmi_device_id'
>    drivers/gpu/drm/mcde/mcde_drv.c:1: warning: 'ST-Ericsson MCDE DRM Driver' not found
>    lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
>    lib/genalloc.c:1: warning: 'gen_pool_free' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
>    include/linux/clk.h:381: warning: Function parameter or member 'num_clks' not described in 'devm_clk_bulk_get_optional'
> >> kernel/rcu/tree.c:2706: warning: Function parameter or member 'krcp' not described in 'kfree_rcu_cpu_work'

Good catch, fix set up to squash into original.

							Thanx, Paul

>    include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
>    include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
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
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2822: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:131: warning: Incorrect use of kernel-doc format:          * @atomic_obj
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:237: warning: Incorrect use of kernel-doc format:          * gpu_info FW provided soc bounding box struct or 0 if not
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:242: warning: Function parameter or member 'soc_bounding_box' not described in 'amdgpu_display_manager'
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'register_hpd_handlers' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_crtc_high_irq' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_pflip_high_irq' not found
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
>    include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
>    include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
>    include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
>    include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
>    include/linux/skbuff.h:893: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'list' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
>    include/linux/skbuff.h:893: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
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
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
>    include/linux/netdevice.h:2040: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
> 
> vim +2706 kernel/rcu/tree.c
> 
>   2694	
>   2695	/**
>   2696	 * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   2697	 * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   2698	 * @head_free: List of kfree_rcu() objects waiting for a grace period
>   2699	 * @kcrp: Pointer to @kfree_rcu_cpu structure
>   2700	 */
>   2701	
>   2702	struct kfree_rcu_cpu_work {
>   2703		struct rcu_work rcu_work;
>   2704		struct rcu_head *head_free;
>   2705		struct kfree_rcu_cpu *krcp;
> > 2706	};
>   2707	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


