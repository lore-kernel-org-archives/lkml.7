Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07666C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22D820684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpUF8Xfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCEEHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:07:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCEEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xr1bc2DdygcwOkBklfprv3E+jDI8FdBTpji1CbQhPPc=; b=SpUF8XfqGtWJjCNAT0hZWUQP9
        3sZnZsOJUJzM22HY4zMuGNO7KF6eBSs1mJevypJhnf7yLtgNipMvSzeqGBSaQgNmDYdrTE77o/U/Z
        1d+0+s9AE/NLIR7x0U+1G2OcYicHjF6R4uVtPcvlNIlBEygWGzzBplVt7QU2V7ehr9ZpV3LIh6bTC
        m4KZeloHTewDzRIDayhafcYt72lb5WuMYIt30j+jGF99Z73VFq5Cs8p9D2sVA3r1X4qdZSkMtQTCJ
        VPZEBVdxtQlOYTBJpjKYonndHE+n/PX7I97cB0szujPy2T9OET61nrcKxpTfRoSQi5aAzgdrdXk4N
        0yHue5UAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h11Lo-00056k-NH; Tue, 05 Mar 2019 04:06:44 +0000
Date:   Mon, 4 Mar 2019 20:06:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Coly Li <colyli@suse.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "harryxiyou@gmail.com" <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@zh-kernel.org" <linux-kernel@zh-kernel.org>
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
Message-ID: <20190305040644.GB13380@bombadil.infradead.org>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com>
 <b2cb92de-ef4a-d628-0dd3-76d8d1b953d0@linux.alibaba.com>
 <CADRPPNSjf4P14bwUMsa10XzBUVLszx4iMsL6gk-XQ0x3vTFr+g@mail.gmail.com>
 <e342a3fa-20f6-46cd-4240-8403fa1aa736@linux.alibaba.com>
 <AM6PR04MB586370DDB6E73A43673339568F710@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <CADRPPNTxDDquY=OT4MV6cQ8OHhAdbazMjngDhtRBCE9_UESg_w@mail.gmail.com>
 <450bd6aa-ec98-b89e-51bc-bb4a22ce7d42@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450bd6aa-ec98-b89e-51bc-bb4a22ce7d42@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:44:28AM +0800, Alex Shi wrote:
> >> Hi Alex,
> >>
> >> I will try to get the new email addresses for others too.   Yes.  But probably I will use a private email for this instead of the company email.
> > Here are the updated email address for me and others.
> >
> > TripleX Chung <xxx.phy@gmail.com>
> > Li Yang <pku.leo@gmail.com>
> > Zhang Wei <wezhang@outlook.com>
> >
> > Since you have created the patch to update my email address to my
> > company email, it is ok to keep that.  Thanks a lot for the effort to
> > address the issue.
> >
> I will update all others email address, and keep your company email address as its your last decision. :)

Don't forget to update .mailmap with the new addresses so scripts which
look for email addresses in commits will use the new addresses for old
commits under the previous names.
