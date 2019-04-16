Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E88420872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sUTH3FgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfDPNkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:40:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34315 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfDPNkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qXgxswxonfoALA9eu49gtYWi5K7iw3nDhH5kLiyToos=; b=sUTH3FgWupS2U3OTbDLlMbutPs
        qkInH9y2QVYGssXKe1gIhfqPFNltqjihyHP/y6nzggbCdd8joTGTFOJi8mslYxvOirO/YB3OUTy+U
        T3TDbtfA+umrz1j0k57Bd0Kpma/uYKZynTgY7M+oqucJCtaRSBdPbO9tkmpzYM0cPpLU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hGOJZ-0007z9-1G; Tue, 16 Apr 2019 15:39:57 +0200
Date:   Tue, 16 Apr 2019 15:39:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: mvebu: at least report the kzalloc failure
Message-ID: <20190416133957.GB29190@lunn.ch>
References: <1555386991-8855-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555386991-8855-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 05:56:31AM +0200, Nicholas Mc Guire wrote:

> Note that this will trigger a checkpatch WARNING
> "WARNING: Possible unnecessary 'out of memory' message"
> but comparing the oops with an without the one-line pr_err I would
> argue that it makes sense to include it:

Hi Nicholas

It might be worth adding this as a comment, so that newbies don't
submit patches removing the pr_err() because of the checkpatch
warning.

       Andrew
