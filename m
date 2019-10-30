Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C25CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224FF2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="JMrxoNWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfJ3Qww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:52:52 -0400
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148]:46699
        "EHLO sonic301-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbfJ3Qwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1572454370; bh=a1fHgbV2gsxc/qTJLuC1KwVssDo9JDASf8CqQzhRyLw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=JMrxoNWpHUiKCqDZGaK7+Kr3SjAtQ3FoMe/j2V9s+egnqEC7yN1RzgMzwMFMBzIfBdz+71E49tTN1QIwFUDv+cduuAhWca4F3dk/J1BUpPGbYbbpjmtX4G9CSJOQv4PeVvR0vZj4JwGVFaI1elFIAEOJ8mPPoOAOJMJuT+f43WPnbj/b9dCO2XnZ0A4iZUVk+7G744ugnDl5JgnLKV9PhdjVH4QX0RekXfLq/Xq4Chf4H7MFVtKe9nueYlfiayUuAvKRoMXXusmRBRsmMfU1A0oxryQ/4GHI5Zlt0cpiLl/yjsYuXVyzMjWSyllJdO2TM0+Rcjh7UJ82BxkbqpqtBw==
X-YMail-OSG: xAMhXSYVM1mVFgtK0BldmKPUfzfYfyQA7hXB0tqZ1buoDcpRFjK1KOkXE2vDdku
 mS0_DTHl7uNhwfTABLCGEqL0IzWLVKrf4CUovUZqk_NWxgKv_DlmP1XifeCvCZF2LpzqOhcTJGLG
 Dm0nzWMyRflAODUEl3e1bTwZYU0gufWn0iiy6Mtgdbpk0qdOPePbPvw5N3tN7DdpZWo07zh6BO1y
 TjwZehv6xDg0ar1LvNVUVE5Vibo0FLKAkatJ3mudnOArjxx9NmenrkXhs0OgrW06HjLVB1cA4YcS
 dB3oZTncNajnuHRwgAtKhqUa7K9Dx2ccbwRZExzSkpx105I8Tp2CVVSxKoKt2MBUJj82GCpdkjcn
 DIye3PaZol8nQqKL7Du8XlYaxAcvsFT3SQaqoLsskRtHgspkORXw1V3_lRGMcac0_Rekl7Erv1J9
 3CMm8Q3WuUb7iR7j6nyUNIABWH1yGQpCl.jQPLqq6f6qV0DYOxE6My06TxLwFRtYYtfDe7JhrM9j
 25FLduRwdsIrD4KgiYcPWYYJoNFQf.BeFOgwv3o2cifm.cfBTc79EF.3oTdqIoe1JWVYYO0IH0A1
 qCSKEjKY0JucuM587EMpbHcqy8JNQO5QmN.T1QVJMkwizewftDr7gUb_PjbRDNSf0WzV3M69WlW1
 _CWKDPVagVJoKK6s2XF53muDbOUBeUgHtQzqAb3pXh5g3QqrLDLMrQ0fBjAoXknjMOICQsd9M2dB
 pLc.N8I8_AWdHq8cSRkD2CeG4EnCn8LcVg3WWCgu8XAVk14.y2OxNAv2lLJfEgD3nrS26a.jPx7n
 nwfm_9QWYpFLaa8TscbhLuaE4i5sizemvJdP01KTo8pTOr7z4CfEyuOgBdd50xVXe1ITLt_EnlnC
 PMZ6IcUhcsrnhWafvutq7ok7dm53F2W.OijwDHLFVLLoAXUbogEjmQo0NbP2GM4e__KItwdj70Xl
 YmioWc0K_w5kfxl7gc8BwHi.srO_qIWrt.jx7aXZlIQot0JHYGoydcghy15YQSOQPABZUG9FU5vk
 CMpwhvECKPzeXTMEWiWfg7c.isOMiHeo9Ut7tfP.45DFVu1X8EER3C.OSa9PjucAfi_x_9wLKFms
 khTO7eFSl1b5AeD.N.c9WXtTT5K2Xxlua04EWhh0jE5LFtPvBW9Heq7BaXqculhHYF.6GeTC0UrF
 rWR.0_ZRCe.EoZWHFtbzMMLRQW2.jbk4lB.3vf8BawbgJLTKbVf1Gy8EOTzL.ESFrVqX8RyHZX_s
 uKB.XmOE0VuIVL_7FOO8LgMjaWoRqUvoK0sPvriMxHLt3fORBmxUscWrrcsIhNbjOiZVLB84aX88
 jkCrYESXAJHZgynhHlaZ2sgKfG11MaPuSP8aTkufW7h8zg3aX4.wBJNRH7nAvgtiQa3Fzpg5bw2t
 e2a49yjXnEg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Oct 2019 16:52:50 +0000
Received: by smtp408.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 39a6ce8385eb3b927ad40666caf4f5e7;
          Wed, 30 Oct 2019 16:52:46 +0000 (UTC)
Date:   Thu, 31 Oct 2019 00:52:39 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
Message-ID: <20191030165226.GC3953@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
 <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191030162243.GA18729@mit.edu>
 <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14593 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:33:13AM -0700, Jaegeuk Kim wrote:
> On 10/30, Theodore Y. Ts'o wrote:
> > On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
> > > 
> > > So I'm curious about the original issue in commit 740432f83560
> > > ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
> > > bios with its internal fio but it seems the commit is not helpful to
> > > resolve potential mempool deadlock (I'm confused since no calltrace,
> > > maybe I'm wrong)...
> > 
> > Two possibilities come to mind.  (a) It may be that on older kernels
> > (when f2fs is backported to older Board Support Package kernels from
> > the SOC vendors) didn't have the bio_alloc() guarantee, so it was
> > necessary on older kernels, but not on upstream, or (b) it wasn't
> > *actually* possible for bio_alloc() to fail and someone added the
> > error handling in 740432f83560 out of paranoia.
> 
> Yup, I was checking old device kernels but just stopped digging it out.
> Instead, I hesitate to apply this patch since I can't get why we need to
> get rid of this code for clean-up purpose. This may be able to bring
> some hassles when backporting to android/device kernels.

Yes, got you concern. As I said in other patches for many times, since
you're the maintainer of f2fs, it's all up to you (I'm not paranoia).
However, I think there are 2 valid reasons:

 1) As a newbie of Linux filesystem. When I study or work on f2fs,
    and I saw these misleading code, I think I will produce similar
    code in the future (not everyone refers comments above bio_alloc),
    so such usage will spread (since one could refer some sample code
    from exist code);

 2) Since it's upstream, I personally think appropriate cleanup is ok (anyway
    it kills net 20+ line dead code), and this patch I think isn't so harmful
    for backporting.

Thanks,
Gao Xiang

> 
> > 
> > (Hence my suggestion that in the ext4 version of the patch, we add a
> > code comment justifying why there was no error checking, to make it
> > clear that this was a deliberate choice.  :-)
> > 
> > 						- Ted
