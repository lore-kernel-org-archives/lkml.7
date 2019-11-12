Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545A206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKLUlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:41:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:18758 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLUlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:41:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="gz'50?scan'50,208,50";a="216155355"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Nov 2019 12:41:30 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iUcyg-0007GL-AG; Wed, 13 Nov 2019 04:41:30 +0800
Date:   Wed, 13 Nov 2019 04:41:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michael Olbrich <m.olbrich@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Olbrich <m.olbrich@pengutronix.de>
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Message-ID: <201911130443.5tw3QYyL%lkp@intel.com>
References: <20191111152645.13792-2-m.olbrich@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6nfbmd6w2qko774b"
Content-Disposition: inline
In-Reply-To: <20191111152645.13792-2-m.olbrich@pengutronix.de>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6nfbmd6w2qko774b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on balbi-usb/next]
[also build test WARNING on v5.4-rc7 next-20191111]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Michael-Olbrich/usb-dwc3-gadget-improve-isoc-handling/20191113-032659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
>> drivers/usb/dwc3/core.h:724: warning: Function parameter or member 'last_frame_number' not described in 'dwc3_ep'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
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
   include/net/sock.h:2450: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2450: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2450: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
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
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:821: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2821: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format:          * @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format:          * gpu_info FW provided soc bounding box struct or 0 if not
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'

vim +724 drivers/usb/dwc3/core.h

72246da40f3719 Felipe Balbi 2011-08-19 @724  

:::::: The code at line 724 was first introduced by commit
:::::: 72246da40f3719af3bfd104a2365b32537c27d83 usb: Introduce DesignWare USB3 DRD Driver

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--6nfbmd6w2qko774b
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6nfbmd6w2qko774b--
