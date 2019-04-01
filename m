Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE006C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460F20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDAPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfDAPHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:07:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AF20AF4C;
        Mon,  1 Apr 2019 15:07:22 +0000 (UTC)
Message-ID: <1554131240.6965.5.camel@suse.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
From:   Jean Delvare <jdelvare@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Wolfram Sang <wsa@the-dreams.de>
Date:   Mon, 01 Apr 2019 17:07:20 +0200
In-Reply-To: <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
References: <20190325183652.252175-1-helgaas@kernel.org>
         <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, 2019-04-01 at 08:50 -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 1:37 PM <helgaas@kernel.org> wrote:
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > convert i2c-isch to platform_device") removed the use of
> > acpi_check_region() but not the include.
> > 
> > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Added
> 
>     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
>     Reviewed-by: Jean Delvare <jdelvare@suse.de>
>     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> on my local branch.
> 
> Jean, would you like me to repost this with the updates?  I assume you
> will merge this (just based on get_maintainer.pl)?

No, Wolfram prefers to pick all the i2c patches into his own branch,
I'm only giving my Reviewed-by. So your question is for him.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
