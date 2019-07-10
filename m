Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD2C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91145208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGJSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:14:16 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.114]:41329 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbfGJSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:14:15 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B7E2C4D1B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:14:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lH6ahlncyYTGMlH6ahdQAR; Wed, 10 Jul 2019 13:14:12 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:60038 helo=[192.168.1.32])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hlH6a-003iiB-BP; Wed, 10 Jul 2019 13:14:12 -0500
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190709182010.GA32200@embeddedor>
 <20190710141526.2f905572@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 mQINBFssHAwBEADIy3ZoPq3z5UpsUknd2v+IQud4TMJnJLTeXgTf4biSDSrXn73JQgsISBwG
 2Pm4wnOyEgYUyJd5tRWcIbsURAgei918mck3tugT7AQiTUN3/5aAzqe/4ApDUC+uWNkpNnSV
 tjOx1hBpla0ifywy4bvFobwSh5/I3qohxDx+c1obd8Bp/B/iaOtnq0inli/8rlvKO9hp6Z4e
 DXL3PlD0QsLSc27AkwzLEc/D3ZaqBq7ItvT9Pyg0z3Q+2dtLF00f9+663HVC2EUgP25J3xDd
 496SIeYDTkEgbJ7WYR0HYm9uirSET3lDqOVh1xPqoy+U9zTtuA9NQHVGk+hPcoazSqEtLGBk
 YE2mm2wzX5q2uoyptseSNceJ+HE9L+z1KlWW63HhddgtRGhbP8pj42bKaUSrrfDUsicfeJf6
 m1iJRu0SXYVlMruGUB1PvZQ3O7TsVfAGCv85pFipdgk8KQnlRFkYhUjLft0u7CL1rDGZWDDr
 NaNj54q2CX9zuSxBn9XDXvGKyzKEZ4NY1Jfw+TAMPCp4buawuOsjONi2X0DfivFY+ZsjAIcx
 qQMglPtKk/wBs7q2lvJ+pHpgvLhLZyGqzAvKM1sVtRJ5j+ARKA0w4pYs5a5ufqcfT7dN6TBk
 LXZeD9xlVic93Ju08JSUx2ozlcfxq+BVNyA+dtv7elXUZ2DrYwARAQABtCxHdXN0YXZvIEEu
 IFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPokCPQQTAQgAJwUCWywcDAIbIwUJ
 CWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBHBbTLRwbbMZ6tEACk0hmmZ2FWL1Xi
 l/bPqDGFhzzexrdkXSfTTZjBV3a+4hIOe+jl6Rci/CvRicNW4H9yJHKBrqwwWm9fvKqOBAg9
 obq753jydVmLwlXO7xjcfyfcMWyx9QdYLERTeQfDAfRqxir3xMeOiZwgQ6dzX3JjOXs6jHBP
 cgry90aWbaMpQRRhaAKeAS14EEe9TSIly5JepaHoVdASuxklvOC0VB0OwNblVSR2S5i5hSsh
 ewbOJtwSlonsYEj4EW1noQNSxnN/vKuvUNegMe+LTtnbbocFQ7dGMsT3kbYNIyIsp42B5eCu
 JXnyKLih7rSGBtPgJ540CjoPBkw2mCfhj2p5fElRJn1tcX2McsjzLFY5jK9RYFDavez5w3lx
 JFgFkla6sQHcrxH62gTkb9sUtNfXKucAfjjCMJ0iuQIHRbMYCa9v2YEymc0k0RvYr43GkA3N
 PJYd/vf9vU7VtZXaY4a/dz1d9dwIpyQARFQpSyvt++R74S78eY/+lX8wEznQdmRQ27kq7BJS
 R20KI/8knhUNUJR3epJu2YFT/JwHbRYC4BoIqWl+uNvDf+lUlI/D1wP+lCBSGr2LTkQRoU8U
 64iK28BmjJh2K3WHmInC1hbUucWT7Swz/+6+FCuHzap/cjuzRN04Z3Fdj084oeUNpP6+b9yW
 e5YnLxF8ctRAp7K4yVlvA7kCDQRbLBwMARAAsHCE31Ffrm6uig1BQplxMV8WnRBiZqbbsVJB
 H1AAh8tq2ULl7udfQo1bsPLGGQboJSVN9rckQQNahvHAIK8ZGfU4Qj8+CER+fYPp/MDZj+t0
 DbnWSOrG7z9HIZo6PR9z4JZza3Hn/35jFggaqBtuydHwwBANZ7A6DVY+W0COEU4of7CAahQo
 5NwYiwS0lGisLTqks5R0Vh+QpvDVfuaF6I8LUgQR/cSgLkR//V1uCEQYzhsoiJ3zc1HSRyOP
 otJTApqGBq80X0aCVj1LOiOF4rrdvQnj6iIlXQssdb+WhSYHeuJj1wD0ZlC7ds5zovXh+FfF
 l5qH5RFY/qVn3mNIVxeO987WSF0jh+T5ZlvUNdhedGndRmwFTxq2Li6GNMaolgnpO/CPcFpD
 jKxY/HBUSmaE9rNdAa1fCd4RsKLlhXda+IWpJZMHlmIKY8dlUybP+2qDzP2lY7kdFgPZRU+e
 zS/pzC/YTzAvCWM3tDgwoSl17vnZCr8wn2/1rKkcLvTDgiJLPCevqpTb6KFtZosQ02EGMuHQ
 I6Zk91jbx96nrdsSdBLGH3hbvLvjZm3C+fNlVb9uvWbdznObqcJxSH3SGOZ7kCHuVmXUcqoz
 ol6ioMHMb+InrHPP16aVDTBTPEGwgxXI38f7SUEn+NpbizWdLNz2hc907DvoPm6HEGCanpcA
 EQEAAYkCJQQYAQgADwUCWywcDAIbDAUJCWYBgAAKCRBHBbTLRwbbMdsZEACUjmsJx2CAY+QS
 UMebQRFjKavwXB/xE7fTt2ahuhHT8qQ/lWuRQedg4baInw9nhoPE+VenOzhGeGlsJ0Ys52sd
 XvUjUocKgUQq6ekOHbcw919nO5L9J2ejMf/VC/quN3r3xijgRtmuuwZjmmi8ct24TpGeoBK4
 WrZGh/1hAYw4ieARvKvgjXRstcEqM5thUNkOOIheud/VpY+48QcccPKbngy//zNJWKbRbeVn
 imua0OpqRXhCrEVm/xomeOvl1WK1BVO7z8DjSdEBGzbV76sPDJb/fw+y+VWrkEiddD/9CSfg
 fBNOb1p1jVnT2mFgGneIWbU0zdDGhleI9UoQTr0e0b/7TU+Jo6TqwosP9nbk5hXw6uR5k5PF
 8ieyHVq3qatJ9K1jPkBr8YWtI5uNwJJjTKIA1jHlj8McROroxMdI6qZ/wZ1ImuylpJuJwCDC
 ORYf5kW61fcrHEDlIvGc371OOvw6ejF8ksX5+L2zwh43l/pKkSVGFpxtMV6d6J3eqwTafL86
 YJWH93PN+ZUh6i6Rd2U/i8jH5WvzR57UeWxE4P8bQc0hNGrUsHQH6bpHV2lbuhDdqo+cM9eh
 GZEO3+gCDFmKrjspZjkJbB5Gadzvts5fcWGOXEvuT8uQSvl+vEL0g6vczsyPBtqoBLa9SNrS
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc1
Message-ID: <3fae69d0-2a7e-107f-e054-d2bdef924704@embeddedor.com>
Date:   Wed, 10 Jul 2019 13:14:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710141526.2f905572@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.149.185
X-Source-L: No
X-Exim-ID: 1hlH6a-003iiB-BP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net ([192.168.1.32]) [201.172.149.185]:60038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 7/9/19 11:15 PM, Stephen Rothwell wrote:
> Hi Gustavo,
> 
> On Tue, 9 Jul 2019 13:20:10 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>>   Makefile: Globally enable fall-through warning (2019-07-08 15:23:22 -0500)
> 
> There are still a few of these warnings in various builds.  My x86_64
> allmodconfig build after merging your tree into Linus' tree this
> morning looked like below (which is way better than when you started).
> I reported (most of) these along the way ...
> 
> arch/x86/events/intel/core.c: In function 'intel_pmu_init':
> arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pmem = true;
>    ~~~~~^~~~~~
> arch/x86/events/intel/core.c:4960:2: note: here
>   case INTEL_FAM6_SKYLAKE_MOBILE:
>   ^~~~
> arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pmem = true;
>    ~~~~~^~~~~~
> arch/x86/events/intel/core.c:5009:2: note: here
>   case INTEL_FAM6_ICELAKE_MOBILE:
>   ^~~~

I sent a patch for the warnings above, but it was ignored.

> fs/btrfs/props.c: In function 'inherit_props':
> fs/btrfs/props.c:389:4: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     btrfs_block_rsv_release(fs_info, trans->block_rsv,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       num_bytes);
>       ~~~~~~~~~~
> drivers/mtd/nand/onenand/onenand_base.c: In function 'onenand_check_features':
> drivers/mtd/nand/onenand/onenand_base.c:3261:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ONENAND_IS_DDP(this))
>       ^
> drivers/mtd/nand/onenand/onenand_base.c:3281:2: note: here
>   case ONENAND_DEVICE_DENSITY_2Gb:
>   ^~~~
> drivers/mtd/nand/onenand/onenand_base.c:3285:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_UNLOCK_ALL;
> drivers/mtd/nand/onenand/onenand_base.c:3287:2: note: here
>   case ONENAND_DEVICE_DENSITY_1Gb:
>   ^~~~

A patch for the above warnings is already queued up:

https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/next&id=db01077c5fffc73fc190d6ce3d68ae083044e4a2

> drivers/net/ethernet/intel/igb/e1000_82575.c: In function 'igb_get_invariants_82575':
> drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (igb_sgmii_uses_mdio_82575(hw)) {
>       ^
> drivers/net/ethernet/intel/igb/e1000_82575.c:642:2: note: here
>   case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
>   ^~~~
> drivers/net/ethernet/intel/igb/igb_main.c: In function '__igb_notify_dca':
> drivers/net/ethernet/intel/igb/igb_main.c:6692:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dca_add_requester(dev) == 0) {
>       ^
> drivers/net/ethernet/intel/igb/igb_main.c:6699:2: note: here
>   case DCA_PROVIDER_REMOVE:
>   ^~~~

Patches for the warnings above have been in Dave's queue for a while:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=42277cedbaf40baef50fd4866b448eb791616b0a
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=b7b3ad7aaf4f5b7ef2561ae3462b2efbfbe23b12

> drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_run_xdp_zc':
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:217:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    bpf_warn_invalid_xdp_action(act);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:218:2: note: here
>   case XDP_ABORTED:
>   ^~~~
> 

This is already in Dave's queue:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=514af5f0995219da7f18d73ecece6e7d1fec8c4e

At some point during this development cycle, we reached the quota of zero
fall-through warnings, but people continued introducing such warnings. So,
it seems we are now pretty much ready for enabling -Wimplicit-fallthrough
globally. Before it turns into a never ending story. :)

Thanks
--
Gustavo
