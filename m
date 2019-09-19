Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA60821907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfISLLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:11:16 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:51373 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfISLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:11:15 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 07:11:15 EDT
Received: (qmail 6848 invoked by uid 1019); 19 Sep 2019 11:04:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Sep 2019 11:04:34 -0000
Date:   Thu, 19 Sep 2019 11:04:34 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Xiang Wang <merle@hardenedlinux.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Subject: RE: [PATCH] arch/riscv: disable too many harts before pick main boot
 hart
In-Reply-To: <MN2PR04MB60618CCE4EAE01B58D25CBCC8D890@MN2PR04MB6061.namprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.999.1909191104040.6796@utopia.booyaka.com>
References: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org> <alpine.DEB.2.21.9999.1909190324250.10826@viisi.sifive.com>
 <MN2PR04MB60618CCE4EAE01B58D25CBCC8D890@MN2PR04MB6061.namprd04.prod.outlook.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019, Anup Patel wrote:

> > From: Xiang Wang <merle@hardenedlinux.org>
> > Date: Fri, 6 Sep 2019 11:56:09 +0800
> > Subject: [PATCH] arch/riscv: disable excess harts before picking main boot
> > hart
> > 
> > Harts with id greater than or equal to CONFIG_NR_CPUS need to be
> > disabled.  But the kernel can pick any hart as the main hart.  So,
> > before picking the main hart, the kernel must disable harts with ids
> > greater than or equal to CONFIG_NR_CPUS.
> > 
> > Signed-off-by: Xiang Wang <merle@hardenedlinux.org>
> 
> You missed my Reviewed-by here.

Thanks, added.

- Paul
