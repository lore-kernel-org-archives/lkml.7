Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB1FC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2151F21835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438229AbfIURNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:13:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:15307 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfIURNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:13:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2019 10:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,532,1559545200"; 
   d="gz'50?scan'50,208,50";a="271840738"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2019 10:13:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iBix0-000HAD-Vl; Sun, 22 Sep 2019 01:13:38 +0800
Date:   Sun, 22 Sep 2019 01:13:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>
Subject: drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in
 expansion of macro 'FIELD_GET'
Message-ID: <201909220123.LePmci49%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="t7us4wgxovsbyxmd"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7us4wgxovsbyxmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f97c81dc6ca5996560b3944064f63fc87eb18d00
commit: bf92e76851009e6bf082db9e9de9b0ab9320cf26 mt76: mt7615: add support for per-chain signal strength reporting
date:   3 months ago
config: x86_64-randconfig-g003-201938 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        git checkout bf92e76851009e6bf082db9e9de9b0ab9320cf26
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/arch_hweight.h:__arch_hweight32
   Cyclomatic Complexity 1 arch/x86/include/asm/arch_hweight.h:__arch_hweight8
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_add
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_sub
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_bh
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_bh
   Cyclomatic Complexity 1 include/linux/rcupdate.h:__rcu_read_lock
   Cyclomatic Complexity 1 include/linux/rcupdate.h:__rcu_read_unlock
   Cyclomatic Complexity 1 include/linux/rcutiny.h:rcu_is_watching
   Cyclomatic Complexity 1 include/linux/dma-debug.h:debug_dma_unmap_page
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:valid_dma_direction
   Cyclomatic Complexity 1 arch/x86/include/asm/dma-mapping.h:get_arch_dma_ops
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:get_dma_ops
   Cyclomatic Complexity 1 include/linux/skbuff.h:skb_get_queue_mapping
   Cyclomatic Complexity 1 include/linux/etherdevice.h:is_multicast_ether_addr
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_has_a4
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_mgmt
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_data
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_data_qos
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_beacon
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_back_req
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_qos_nullfunc
   Cyclomatic Complexity 2 include/linux/ieee80211.h:ieee80211_get_qos_ctl
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_rate_get_vht_mcs
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_rate_get_vht_nss
   Cyclomatic Complexity 1 include/net/mac80211.h:IEEE80211_SKB_CB
   Cyclomatic Complexity 1 drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h:mt76_get_txwi_ptr
   Cyclomatic Complexity 3 drivers/net/wireless/mediatek/mt76/mt7615/../mt76.h:wcid_to_sta
   Cyclomatic Complexity 2 include/net/mac80211.h:ieee80211_tx_info_clear_status
   Cyclomatic Complexity 21 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_fill_txs
   Cyclomatic Complexity 8 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_rx_get_wcid
   Cyclomatic Complexity 4 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:to_rssi
   Cyclomatic Complexity 1 include/linux/netdevice.h:dev_kfree_skb_any
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_is_direct
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_unmap_page_attrs
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_unmap_single_attrs
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_acquire
   Cyclomatic Complexity 4 include/linux/rcupdate.h:rcu_read_lock
   Cyclomatic Complexity 6 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_add_txs_skb
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_tx_status_noskb
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_release
   Cyclomatic Complexity 4 include/linux/rcupdate.h:rcu_read_unlock
   Cyclomatic Complexity 37 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_fill_rx
   Cyclomatic Complexity 1 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_sta_ps
   Cyclomatic Complexity 5 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_tx_complete_skb
   Cyclomatic Complexity 16 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_tx_rate_val
   Cyclomatic Complexity 47 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_write_txwi
   Cyclomatic Complexity 2 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_txp_skb_unmap
   Cyclomatic Complexity 8 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_tx_prepare_skb
   Cyclomatic Complexity 10 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_add_txs
   Cyclomatic Complexity 4 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_tx_free
   Cyclomatic Complexity 1 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:mt7615_mac_work
   Cyclomatic Complexity 1 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:_GLOBAL__sub_I_00100_0_mt7615_mac_fill_rx
   Cyclomatic Complexity 1 drivers/net/wireless/mediatek/mt76/mt7615/mac.c:_GLOBAL__sub_D_00100_1_mt7615_mac_fill_rx
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:23,
                    from include/linux/etherdevice.h:25,
                    from drivers/net/wireless/mediatek/mt76/mt7615/mac.c:10:
   drivers/net/wireless/mediatek/mt76/mt7615/mac.c: In function 'to_rssi':
>> include/linux/compiler.h:345:38: error: call to '__compiletime_assert_18' declared with attribute error: BUILD_BUG_ON failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) & (((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) != 0
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:326:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:345:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:54:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
      ^~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
      ^~~~~~~~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in expansion of macro 'FIELD_GET'
     return (FIELD_GET(field, rxv) - 220) / 2;
             ^~~~~~~~~
>> include/linux/compiler.h:345:38: error: call to '__compiletime_assert_18' declared with attribute error: BUILD_BUG_ON failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) & (((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) != 0
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:326:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:345:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> include/linux/build_bug.h:21:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
     ^~~~~~~~~~~~
>> include/linux/bitfield.h:62:3: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
      ^~~~~~~~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7615/mac.c:18:10: note: in expansion of macro 'FIELD_GET'
     return (FIELD_GET(field, rxv) - 220) / 2;
             ^~~~~~~~~
--
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/arch_hweight.h:__arch_hweight32
   Cyclomatic Complexity 1 arch/x86/include/asm/arch_hweight.h:__arch_hweight8
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_add
   Cyclomatic Complexity 5 arch/x86/include/asm/preempt.h:__preempt_count_sub
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_bh
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_bh
   Cyclomatic Complexity 1 include/linux/rcupdate.h:__rcu_read_lock
   Cyclomatic Complexity 1 include/linux/rcupdate.h:__rcu_read_unlock
   Cyclomatic Complexity 1 include/linux/rcutiny.h:rcu_is_watching
   Cyclomatic Complexity 1 include/linux/dma-debug.h:debug_dma_unmap_page
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:valid_dma_direction
   Cyclomatic Complexity 1 arch/x86/include/asm/dma-mapping.h:get_arch_dma_ops
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:get_dma_ops
   Cyclomatic Complexity 1 include/linux/skbuff.h:skb_get_queue_mapping
   Cyclomatic Complexity 1 include/linux/etherdevice.h:is_multicast_ether_addr
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_has_a4
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_mgmt
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_data
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_data_qos
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_beacon
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_back_req
   Cyclomatic Complexity 1 include/linux/ieee80211.h:ieee80211_is_qos_nullfunc
   Cyclomatic Complexity 2 include/linux/ieee80211.h:ieee80211_get_qos_ctl
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_rate_get_vht_mcs
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_rate_get_vht_nss
   Cyclomatic Complexity 1 include/net/mac80211.h:IEEE80211_SKB_CB
   Cyclomatic Complexity 1 drivers/net/wireless//mediatek/mt76/mt7615/../mt76.h:mt76_get_txwi_ptr
   Cyclomatic Complexity 3 drivers/net/wireless//mediatek/mt76/mt7615/../mt76.h:wcid_to_sta
   Cyclomatic Complexity 2 include/net/mac80211.h:ieee80211_tx_info_clear_status
   Cyclomatic Complexity 21 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_fill_txs
   Cyclomatic Complexity 8 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_rx_get_wcid
   Cyclomatic Complexity 4 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:to_rssi
   Cyclomatic Complexity 1 include/linux/netdevice.h:dev_kfree_skb_any
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_is_direct
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_unmap_page_attrs
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_unmap_single_attrs
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_acquire
   Cyclomatic Complexity 4 include/linux/rcupdate.h:rcu_read_lock
   Cyclomatic Complexity 6 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_add_txs_skb
   Cyclomatic Complexity 1 include/net/mac80211.h:ieee80211_tx_status_noskb
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_release
   Cyclomatic Complexity 4 include/linux/rcupdate.h:rcu_read_unlock
   Cyclomatic Complexity 37 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_fill_rx
   Cyclomatic Complexity 1 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_sta_ps
   Cyclomatic Complexity 5 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_tx_complete_skb
   Cyclomatic Complexity 16 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_tx_rate_val
   Cyclomatic Complexity 47 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_write_txwi
   Cyclomatic Complexity 2 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_txp_skb_unmap
   Cyclomatic Complexity 8 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_tx_prepare_skb
   Cyclomatic Complexity 10 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_add_txs
   Cyclomatic Complexity 4 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_tx_free
   Cyclomatic Complexity 1 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:mt7615_mac_work
   Cyclomatic Complexity 1 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:_GLOBAL__sub_I_00100_0_mt7615_mac_fill_rx
   Cyclomatic Complexity 1 drivers/net/wireless//mediatek/mt76/mt7615/mac.c:_GLOBAL__sub_D_00100_1_mt7615_mac_fill_rx
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:23,
                    from include/linux/etherdevice.h:25,
                    from drivers/net/wireless//mediatek/mt76/mt7615/mac.c:10:
   drivers/net/wireless//mediatek/mt76/mt7615/mac.c: In function 'to_rssi':
>> include/linux/compiler.h:345:38: error: call to '__compiletime_assert_18' declared with attribute error: BUILD_BUG_ON failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) & (((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) != 0
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:326:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:345:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:54:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
      ^~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
      ^~~~~~~~~~~~~~~~
   drivers/net/wireless//mediatek/mt76/mt7615/mac.c:18:10: note: in expansion of macro 'FIELD_GET'
     return (FIELD_GET(field, rxv) - 220) / 2;
             ^~~~~~~~~
>> include/linux/compiler.h:345:38: error: call to '__compiletime_assert_18' declared with attribute error: BUILD_BUG_ON failed: (((field) + (1ULL << (__builtin_ffsll(field) - 1))) & (((field) + (1ULL << (__builtin_ffsll(field) - 1))) - 1)) != 0
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:326:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:345:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> include/linux/build_bug.h:21:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
     ^~~~~~~~~~~~
>> include/linux/bitfield.h:62:3: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
      ^~~~~~~~~~~~~~~~
   drivers/net/wireless//mediatek/mt76/mt7615/mac.c:18:10: note: in expansion of macro 'FIELD_GET'
     return (FIELD_GET(field, rxv) - 220) / 2;
             ^~~~~~~~~

vim +/FIELD_GET +18 drivers/net/wireless/mediatek/mt76/mt7615/mac.c

    15	
    16	static inline s8 to_rssi(u32 field, u32 rxv)
    17	{
  > 18		return (FIELD_GET(field, rxv) - 220) / 2;
    19	}
    20	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--t7us4wgxovsbyxmd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKZUhl0AAy5jb25maWcAjFxfc9y2rn/vp9hJX9o5k9Z2XDf33vEDJVFadiVRIam11y8a
19nkeOrYOWv7tPn2FyD1h6Sgbc/cuc0SIAWSIPADCPr7775fsdeXpy+3L/d3tw8P31af94/7
w+3L/uPq0/3D/v9WmVzV0qx4JsxPwFzeP77+9fNf7y+6i/PVLz+d/XTy9nB3utrsD4/7h1X6
9Pjp/vMr9L9/evzu++/g/76Hxi9fYajD/64+3929/XX1Q7b//f72cfXrT+fQ+/Tdj+5fwJvK
OhdFl6ad0F2Rppffhib40W250kLWl7+enJ+cjLwlq4uRdOINsWa6Y7rqCmnkNFBPuGKq7iq2
S3jX1qIWRrBS3PAsYMyEZknJ/wmzrLVRbWqk0lOrUB+6K6k2U0vSijIzouIdvzZ2bC2Vmehm
rTjLOlHnEv5fZ5jGznYVC7svD6vn/cvr12mtEiU3vO5k3emq8T4NUna83nZMFV0pKmEu353h
XgzyVo2Arxuuzer+efX49IIDD71LmbJyWNM3b6jmjrX+stqJdZqVxuNfsy3vNlzVvOyKG+GJ
51MSoJzRpPKmYjTl+maph1winANhXABPKn/+Md3KdowBJTxGv7453lsSqx9I3LdlPGdtabq1
1KZmFb9888Pj0+P+x3Gt9RXz1lfv9FY06awB/5ua0l+JRmpx3VUfWt5yUtZUSa27ildS7Tpm
DEvXJF+reSkSksRasB7ETO0GMZWuHQcKx8py0Hg4Pqvn19+fvz2/7L9MGl/wmiuR2tPVKJlw
z0p4JL2WVzQlXfuqiC2ZrJiowzYtKoqpWwuuUOTdfPBKC+RcJMy+40tVMaNgI2D+cMrAjtBc
imuutszgCaxkxkMRc6lSnvVWRNSFt/8NU5rT0lnJeNIWubaKsX/8uHr6FC3/ZG9lutGyhQ+B
XTTpOpPeZ+xe+iwZM+wIGc2UZ0U9yhZMLHTmXcm06dJdWhL7bC3pdlKbiGzH41teG32UiEaU
ZSl86DhbBdvPst9akq+SumsbFHnQX3P/ZX94plTYiHQDJpuDjnpDrW+6BsaSmUj9A1pLpIis
pI+nJVNnSxRrVBe7SCrY2ZlgQ59GcV41BsaseWAj+vatLNvaMLUjJem5CFmG/qmE7sPypE37
s7l9/mP1AuKsbkG055fbl+fV7d3d0+vjy/3j52jBoEPHUjuG0+3xy1uhTETGjSEkQV23WkMP
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

--t7us4wgxovsbyxmd--
