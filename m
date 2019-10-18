Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20565CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943C21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbfJRGJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:09:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:63537 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392128AbfJRGJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:09:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 23:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,310,1566889200"; 
   d="scan'208";a="226433501"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2019 23:09:37 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.148])
        by linux.intel.com (Postfix) with ESMTP id 8DF7858049A;
        Thu, 17 Oct 2019 23:09:34 -0700 (PDT)
Message-ID: <ab24122b93e08d23590b62be0ac4162229baf3d2.camel@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Date:   Fri, 18 Oct 2019 09:09:33 +0300
In-Reply-To: <20191017142229.3853-1-miquel.raynal@bootlin.com>
References: <20191017142229.3853-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 16:22 +0200, Miquel Raynal wrote:
> Despite their substantial personal investment in the MTD/UBI/UBIFS a
> few years back, David, Brian, Artem and Adrian are not actively
> maintaining the subsystem anymore. We warmly salute them for all the
> work they have achieved and will of course still welcome their
> participation and reviews.
> 
> That said, Marek retired himself a few weeks ago quoting Harald [1]:
> 
>         It matters who has which title and when. Should somebody not
>         be an active maintainer, make sure he's not listed as such.
> 
> For this same reason, let’s trim the maintainers list with the
> actually active ones over the past two years.

I am fine with being removed from maintainers, thanks!

