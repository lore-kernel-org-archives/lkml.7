Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12554C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38A4206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfKEXLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:11:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55383 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKEXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:11:34 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 050ac5c5179a3f27; Wed, 6 Nov 2019 00:11:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic" cell to CHT cells
Date:   Wed, 06 Nov 2019 00:11:32 +0100
Message-ID: <9960583.3dFhK665ib@kreacher>
In-Reply-To: <20191101090111.GG5700@dell>
References: <20191024213827.144974-1-hdegoede@redhat.com> <20191024213827.144974-5-hdegoede@redhat.com> <20191101090111.GG5700@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 1, 2019 10:01:11 AM CET Lee Jones wrote:
> On Thu, 24 Oct 2019, Hans de Goede wrote:
> 
> > Add a "cht_crystal_cove_pmic" cell to the cells for the Cherry Trail
> > variant of the Crystal Cove PMIC. Adding this cell enables / hooks-up
> > the new Cherry Trail Crystal Cove PMIC OpRegion driver.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_crc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Applied, thanks.

OK, I need to drop it then, thanks!



