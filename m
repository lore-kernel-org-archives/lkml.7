Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE272C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C7121907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="bNa8B5zM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfIRWos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:44:48 -0400
Received: from sonic302-22.consmr.mail.gq1.yahoo.com ([98.137.68.148]:39299
        "EHLO sonic302-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbfIRWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1568846686; bh=qeWM3clNU3uJNRLTBgPkz0oq23aWLhRpnv07nYVU28A=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=bNa8B5zMNrhPfbC8eYyT9//9+mIlw8wpsDjvtdrD5IsaAetmdK6fWPrZtrzm2bAvTRreurVTOg1zJhintRJEeGhGf47vgysXD+cHMi6YFI5H3svEZ+LzZ3t/B+BhhXXCD6dsSyMBXPqXlOXnXsGWwgUfjHbb8xZTJ/RwZhLRHSggnCiUys9x599xgfuRiijCOURe8cqnjM+wXNngYp1wYdt2c10q1sZo5cGSeNI9+NUmsoevY+wdeThFE931s6AKBqfEEkC7yyijtl1l7j62A4x5Qx0IGNwrmuGkoni+n77qyBQUBvHL3/9Izymjrb/U7i45oHsYxaZs3IYa5X6QXg==
X-YMail-OSG: 3BwkIqwVM1kY_qtQ.9X84HAiACEg9mMdyPXHUG9kqjWOJZPdJMknKXzAYSlJXE0
 Y4mH79kc1pjtuJCp7t_KRm4yC2bJxjP.WPfoNtFKsoEoJQz4C7nCCk_evUoTHXAZO7_6C_kwLRR9
 qHgv9WjRbd9wy8MXRmltBEBDdgZ1RDbFIh_SE0H3UD_GHy1sNbl2pVNO6UsORsPxHhTBX2eagRpY
 6jQyVlw21bVJYEDQDv4B3Lv0f6BWf15aEv7.It7UvTIwZS11143Fd63_htwV0xXXXhuXqo8iwEMk
 vfBjkHRqfbVMKGIlFHs8BzKRIZ3a7vG3BfHSBZ7536AWJNNHLf3epV3TC41Zf8FevnHBYWRwSZzB
 hC9pGeNY1G3sGNRc0TeTwtWyNcNGag8GR48EX2f7_DecfELx54fKqJOLwHAj44M47mj2n0QBO2LU
 DTziHVxkK48cECb5thoMdilFmaTNPGxES08B.ooGINds.GhmDOcvClqwYXca2sphU8jPOyAz1U9N
 MIi1iUg3xpBxoBIR3499h2vSRwCRQHuqpjvczVW_Hiotl._Ueh9Pkup3t92lwUSgtUxMBVV3dXqP
 QiCIUBIOWIVhbCgXIj_WvF.spJM.WWc2eDbtCArRBSRbIYopUqEr5fIW1HQwSZVedc.4AXOjNvAK
 soT5_uYj6pmBBiWYK12Dweo51K4D0KLi1WL7EkVTv_WC.8KcQ9LByWWo7.B94I6vYo1Wij4h1L.W
 NKo9gaxJRSR1xtqbK0V2dpZBhLpTk2MYxvsCABIJV.gR8IQYY2IUWp_cZULzmQkA_jXIL37NkbIl
 pYqYNGDLqHS9LeEQ11naxMz8Q8ADyxX3zgQlLMmE3NLJ.niuJkkCLP4mkS49dvKQbSEf.C3zeB6M
 l3z2kiqdG5izpKlifH3xYKS7fANnvmNtqFf4PCqLY4Bf1zgVtr95ynhY0SCV.R_3ErfGBDkg9JIE
 hZEqpsfDqa1aLTSLX_ajISNuFI81wBEa7rvtyyHiiDWY6evP5J50lyImALLWctR53cbvAKblysMr
 onRMP4KmMeUzLainlUsu6Suu4kLVJw1qFmIF5vGl8jAUJ5qLyRBtuozE4gX817Y0EngbWOkS.ume
 kYQdeYfB51zXhbDBWXI6XnozeA_ZRzsNFK_HS0sX.a8_7HypdC9S1XxeV.wUfYh9CWr8RgBZ8peb
 owUVeOUdozwoUtuzWX2ENyw43cQPWp4SIe3TUUnOwVAJCVe0j62MlRfceb3K393VWSf9S77DiWQd
 3qBOygO6qKtMhkW7gnrARGwMJTuSO_CVoWdDukbe8PrRmE3LYuvQnkzruGiggw44awI7XXRpGN1P
 oBrtCbUJ.pJUdKljyFTcTrQGYAqXKIHiW3d8rL4Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 18 Sep 2019 22:44:46 +0000
Received: by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70c22b09dff901a0cf446ffa2243c519;
          Wed, 18 Sep 2019 22:44:44 +0000 (UTC)
Date:   Thu, 19 Sep 2019 06:44:39 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
Message-ID: <20190918224435.GA25175@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190918114754.GA1899504@kroah.com>
 <20190918182412.GA9924@infradead.org>
 <20190918211123.GA22600@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918211123.GA22600@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14303 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:11:28AM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Wed, Sep 18, 2019 at 11:24:12AM -0700, Christoph Hellwig wrote:
> > Just as a note of record:  I don't think either file system move
> > is a good idea.  erofs still needs a lot of work, especially in
> > interacting with the mm code like abusing page->mapping.
> 
> I know what you mean, that is a known stuff in the TODO list,
> Z_EROFS_MAPPING_STAGING page->mapping just be used as a temporary
> page mark since page->private is already pointed to another
> structure, It's now be marked as an non-movable and anon pseudo
> mapping and most mm code just skip this case.

Add a word, these pages are all non-LRU and short lifetime temporary
pages (and need to differentiate with other NULL mapping pages [a lot
of different type pages could have this intermediate state]).

Alternate way is to use some page flag but that is what I really
want to avoid this limited resource.

For EROFS, it's widely deployment on each new HUAWEI mobile phones
on the market this year and all old HUAWEI modile phones are still
supported by upgrading to EROFS version and there are many pending
new features for EROFS and a mature fixed-sized output compression
subsystem in the future if more fs users have interested in that
and I think it's good for whole linux ecosystem not just on a single
filesystem upstreaming basis and we will continue working on this area.

Thanks,
Gao Xiang

> 
> I think a better way is to use a real address_space structure for
> page->mapping to point. It's easy to update but I need some time
> to verify. If I am wrong, please point it out...
> 
> Thanks,
> Gao Xiang
> 
