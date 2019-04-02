Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8341C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E42084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="UyuLppm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfDBFzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:55:54 -0400
Received: from mail.nic.cz ([217.31.204.67]:55733 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBFzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:55:54 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 043D36235E;
        Tue,  2 Apr 2019 07:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1554184552; bh=7zfPL/cJkg8+ITpykArY892fH9+vSdXjjHKQlwdr4ts=;
        h=Date:From:To;
        b=UyuLppm4ZnAB/9eR8laGAj2tzePeZLaJGWtgvNQLm1q51RlLq/GMib5buXUNhg0yR
         OXoY8/NKIBcr6bbwPEiEU7dFTXLkLS9FTSDVvm8e9hCghdVcTijV2qG8ijrpAFqc3v
         +N3yFzsgM4stkFoanxM3U+NSfav2cK2zzc08PfkI=
Date:   Tue, 2 Apr 2019 07:55:51 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] documention: leds: Add multicolor class
 documentation
Message-ID: <20190402075551.03e296f3@nic.cz>
In-Reply-To: <20190401212709.GA14681@amd>
References: <20190401173400.14238-1-dmurphy@ti.com>
        <20190401173400.14238-4-dmurphy@ti.com>
        <20190401212709.GA14681@amd>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 23:27:10 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> One was discussed before -- have single file which contains
> coefficients for r/g/b channels.

That would somehow break the rule one file/one value. Although you
could consider the whole color one value, that way it would not be
broken...
