Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54922C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E871206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kt9Gf4+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEGP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:27:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57408 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfEGP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hYYkSXMEcEBMKHDB90Je/x8ZZZjEKeotZ0mixjMK64g=; b=kt9Gf4+ZTrnA7nLbv4sc7uXpX5
        fR01d6vMlSFr0ZCtOCi6xc51xhgy4yzS9nstdzEYAMbhvCRhS+tPsbxxIDUZagjzNhV8Xz61WROhJ
        wXc4OPSXvPQCJkESOzc/gEPACCEXRgR1Gtze/ioMOuX6UmEm+m7aQUosPz9p7n6L41o0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hO205-0001DO-Ho; Tue, 07 May 2019 17:27:25 +0200
Date:   Tue, 7 May 2019 17:27:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 v2 0/3] Extend dt bindings to support I2C on sifive
 devices and a fix broken IRQ in polling mode.
Message-ID: <20190507152725.GE25013@lunn.ch>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The information transmitted is intended only for the person or entity to 
> which it is addressed and may contain confidential and/or privileged 
> material. If you are not the intended recipient of this message please do 
> not read, copy, use or disclose this communication and notify the sender 
> immediately. It should be noted that any review, retransmission, 
> dissemination or other use of, or taking action or reliance upon, this 
> information by persons or entities other than the intended recipient is 
> prohibited.

You need to remove this. It is nonsense anyway. You are mailing to a
public list....

       Andrew
