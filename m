Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001F2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C024F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/+sj8dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDCUXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:23:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qtbnftFclfRCCtsM3EVzP3WKwVXYIc9e7qGRZbi7Asc=; b=s/+sj8dwXrmc8eENpzH68+Mmld
        KqlU10N46n3kzLq4FHX2LJ8Bz8g/u+SOXf5WF4z6l7pWdq9SLXqTjauJQTqVgCvuRffYzR0fsq5ca
        eX/bYriE6u084F4mVXAOngH/s7hbvB5o5Kn2hvWwy+72VBUMHMvAqLK/q65nEKo5vD6AHwCi8EyMK
        96HmrlaPRKxTmTiUnx4jPPzyVw+Jd1u1Sq33GQt3WqlCC/rlZljWPRjJ58BjesDIJpo6lUYbzUDOz
        efJwTC2udtA5Iy8ILRmuhMUMiKK8GBpfNicROxf282fqfgbXi6V+d4RKb9Ykvtam8WGzHYWkS6UCX
        N13I0qLw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBmQD-000871-8r; Wed, 03 Apr 2019 20:23:45 +0000
Date:   Wed, 3 Apr 2019 13:23:38 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
Message-ID: <20190403202338.GB39081@wrath>
References: <1553696734-31282-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553696734-31282-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:25:34AM -0500, Mario Limonciello wrote:
> When converting the driver two arguments were transposed leading
> to rfkill not working.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201427
> Reported-by: Pepijn de Vos <pepijndevos@gmail.com>
> Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM calls")
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Acked-by: Pali Rohár <pali.rohar@gmail.com>

Looks like this broken in 4.14? So Cc stable back to then? I'm surprised it's
been broken that long :-(

-- 
Darren Hart
VMware Open Source Technology Center
