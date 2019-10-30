Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5942ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2DA208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Un1nk9Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfJ3RWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:22:54 -0400
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205]:36441
        "EHLO sonic304-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfJ3RWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1572456172; bh=Kb4n1V0seA/ZgYHtBmZ8iV+zYnoNVd+L2wWX8RTfW1M=; h=Date:From:To:Subject:References:In-Reply-To:From:Subject; b=Un1nk9EkHYaK0BMxOM2tsndHhH/1x7yC0PS/+NhGQ3LFO5nZPw5xTtjOruCj2M/rZTMW18a7omSDc3toddZXTQN8RLsp5aGtea9mAuYHsLVmlJh7YPVzO5HaFe7jzGc3q62eTbmCl/Agy8RToWDrzP0pJdFWWjm+RrVnyDpie88KuNvUISYkAxt9hMqBHOaJuHun2Jvko4G/FpJINmsvRIQxF6mi1vWYDIT4iwRM7GEQGmx1Q8/ioFomSEwdh0MRenk/YDpNEkRGuwp+o83xMD88bBZ/ybqSEF9qX7Ik3p2Jr4Y24F/VGHrH0aI/BRzE0le28sLe0OWz440AiTQgqg==
X-YMail-OSG: 9NV7YMwVM1li.vt0Wt_kGHuCLM6N2Rp7_uQIRZFfJ7mGGG.1e68Rtg8Ra6trvAd
 0T9LvpWHgRtlywhsGdG4YIBh2LXsRpT3CHlyuELKnHvI18e_Rw94OnJH9WtEl2xZ6_xBS6SYGZ2C
 BsreKwFbODvzvDarCJn3XSiXj8ne8RN2vxQ24ogdT5KoaM.ufezIc5d1X9dW7cyN35n16zJp9cSz
 dxXdCDKpK5ST3MKZIuwtOUFoTt.mPr22B2HdfLB2CaE.RCr5SjmNSoJsnC8oAe0wXP5A5DppDWio
 E886lfvRy3wBanP.UQWZBtHM50M6SnWKIr6HLEPn7.r4hZUI_eNRV6kF6fAzbXpSXnUiOxtCnVzF
 hHErg6VLrx286dzhFkHaBpEEDpXF8EZUyo.kX3gqxxOD4RkcmzocfHVCeik.ukZOmvEzVPYG0z2j
 Znlk3noB3pXf2nyw5JFcte8cSn.HQ0r0BtFGfRIh0mdLoLMDTyDJZZmUl1arQc_Czi5AxqPcxzHJ
 KXwl_7V_lmyPjbVP0anKSX4AkJddT455bEEjdlfKGQ8lcKmDEGCyjENOCLc0MIzx6kenTbeGJpyX
 o3ofVD9mPGAPGY6kFoE.WlHEeXXqyv_nJ_s7UaDzPLri0ddtt.5gKHpH4Q_5Clx65SWFrLWyh7ho
 3cm5guUNcFaddNsbqmSjvXHeAjIO4zsJGkrbUjVJKQdSCv3fEPcNvHUkNQlUI6LrEiyZxiaBylUK
 9d8mpYHtW0NXsg83D3EJrZ3M19q.eq8BkSmGcRtku8h2r7GcBcmeWX85HSlJ0w_HcpmIDz0g1S5S
 9XsWQovO7r5EhpY67TBnbbmoYCVk36asjR_gDyogp.06Y63jhD_UHnNWSbN3Larh_CUXMz7TPpTs
 GrNJiTCrRDPxiNUq9ia6FsWNZ4Eo6hD90fiSr00uB9fTky5RPGXJ4ilnRcSdhiX6j6BmfoT_Tvfv
 VsnpNrWA95JmH4ktnyE46.jJWl28x46suX2eW8JJOrsyZgt5vPN6Cq6gCXnPLkBUTOtAQISOTfGJ
 y__BWhFArZgROHVUwyAJjmZFBigK0GInRhtSmqz8w66rYwZzOaeGUOTe13S4GSdpxMhwiH2SvsCi
 PKFwpYaxGbehsb9AbS_ccC3QVhiZyNgjeqONh5t1SMncpNhck0JSjkyJ0pc7J1pMKvmSZ5U.QkKz
 0zyJ3pqnKCi62C2J0q6jFKjzC.FYsO5mZDDqcU2axUh8GhsVSu.zBW1NB3SUz8j5_JjqsftSewFS
 V5rwJnDq7JAvY6.35Br0J8USDelvfFLxVxTuIfC.KtdTx_DqBSoPnqvPNTjCwZxxOJx2HipgGEVA
 vqKtD36H20RIuHquq6D_5FKxsfd07ESIuINmMsMGVPQc45BAgeIhYVMq4E72.vbcHEW8ra5PpVOA
 fKEmF7TLQVw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Oct 2019 17:22:52 +0000
Received: by smtp415.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c6b74f9a96653bcbb72edbf42affa5a8;
          Wed, 30 Oct 2019 17:22:50 +0000 (UTC)
Date:   Thu, 31 Oct 2019 01:22:44 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support data compression
Message-ID: <20191030172234.GA7018@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
 <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
 <20191030165056.GA693@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030165056.GA693@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14593 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

(add some mm folks...)

On Wed, Oct 30, 2019 at 09:50:56AM -0700, Eric Biggers wrote:

<snip>

> > >>>
> > >>> It isn't really appropriate to create fake pagecache pages like this.  Did you
> > >>> consider changing f2fs to use fscrypt_decrypt_block_inplace() instead?
> > >>
> > >> We need to store i_crypto_info and iv index somewhere, in order to pass them to
> > >> fscrypt_decrypt_block_inplace(), where did you suggest to store them?
> > >>
> > > 
> > > The same place where the pages are stored.
> > 
> > Still we need allocate space for those fields, any strong reason to do so?
> > 
> 
> page->mapping set implies that the page is a pagecache page.  Faking it could
> cause problems with code elsewhere.

Not very related with this patch. Faking page->mapping was used in zsmalloc before
nonLRU migration (see material [1]) and use in erofs now (page->mapping to indicate
nonLRU short lifetime temporary page type, page->private is used for per-page information),
as far as I know, NonLRU page without PAGE_MAPPING_MOVABLE set is safe for most mm code.

On the other hands, I think NULL page->mapping will waste such field in precious
page structure... And we can not get such page type directly only by a NULL --
a truncated file page or just allocated page or some type internal temporary pages...

So I have some proposal is to use page->mapping to indicate specific page type for
such nonLRU pages (by some common convention, e.g. some real structure, rather than
just zero out to waste 8 bytes, it's also natural to indicate some page type by
its `mapping' naming )... Since my English is not very well, I delay it util now...

[1] https://elixir.bootlin.com/linux/v3.18.140/source/mm/zsmalloc.c#L379
    https://lore.kernel.org/linux-mm/1459321935-3655-7-git-send-email-minchan@kernel.org
    and some not very related topic: https://lwn.net/Articles/752564/

Thanks,
Gao Xiang

