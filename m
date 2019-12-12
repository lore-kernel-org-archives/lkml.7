Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E49C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA224656
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="kpjgNJ8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfLLHeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:34:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38321 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfLLHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:34:06 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 338B423D09;
        Thu, 12 Dec 2019 08:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576136044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahNlfZRgvyxNMfLruGaGs7saGlzvDiLyQV2jVcLv9i0=;
        b=kpjgNJ8csN4y9W3dOZcgoA6Xm76QjIO2uzLC68Ruww0eJJVhotfhADAkr62cQnzi/SCblo
        5TvosPORI6iVRAbMsuIcEzzdkoZRjp118ofA3dxSdiRr1fU8Cnk/z5/1bK5c1OrISEjMTx
        oLzv39WgUp0awOhIjHDIErTaNTB7DL4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Dec 2019 08:34:03 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] arm64: dts: ls1028a: fix reboot node
In-Reply-To: <20191212020055.GB15858@dragon>
References: <20191211171145.14736-1-michael@walle.cc>
 <20191212020055.GB15858@dragon>
Message-ID: <ad3885c9545cb73eced2fa3f0ce6f0be@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 338B423D09
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.285];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-12-12 03:00, schrieb Shawn Guo:
> On Wed, Dec 11, 2019 at 06:11:45PM +0100, Michael Walle wrote:
>> The reboot register isn't located inside the DCFG controller, but in 
>> its
>> own RST controller. Fix it.
>> 
>> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> You missed Leo's ACK on v2?  I added it and applied the patch.

Yes, I forgot to add that, thanks.

-michael
