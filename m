Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D65C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="w4lvESwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDKWHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:07:10 -0400
Received: from mail.nic.cz ([217.31.204.67]:49539 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfDKWHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:07:09 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 7F25663659;
        Fri, 12 Apr 2019 00:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1555020427; bh=zANAfkTeUccyPRA6yIe650tbdNB0uv7DtMxWXqvQxG0=;
        h=Date:From:To;
        b=w4lvESwYUvwX8hMP6SyVFwTpS3vzv6jKagTdWAqdaR8ViNCt9TRVuajLXIv2A6iZz
         Y3HDxoz3IxjojIgaKkUtPaa7PaXFPrvgjIWQFrScj2X/pAG2X6/pdkdnNVbf39A6zQ
         w+9ZdjuAq9EYWziJbLaMf3FGqS1hP5XssTcJneC0=
Date:   Fri, 12 Apr 2019 00:07:07 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
Message-ID: <20190412000707.70f8319f@nic.cz>
In-Reply-To: <20190411193848.23140-3-dmurphy@ti.com>
References: <20190411193848.23140-1-dmurphy@ti.com>
        <20190411193848.23140-3-dmurphy@ti.com>
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

Hi Dan,
this probaly was discussed, but I did not follow brightness model
discussions:
what will happen if I set yellow by writing into yellow mode
brightness, and then orange by writing orange model brightness?
Will the resulting color be a mix of yellow and orange, or will the
orange overwrite the yellow setting?

Marek
