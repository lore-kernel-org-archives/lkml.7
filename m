Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7799AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC82133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560845210;
	bh=vmefZDb3xtY3+JowXEb+2DJa4rQS3eadY9mZe/G1U6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcdIEqV334hBXKj7vEPpZbfr814vs604VmkIF237DNdYGCs8/7oO4UI1L3mttv8QN
	 bfe6Jps75xZVcgUfZsrBQ2gKDsrVAqVDHfzTycy5LGuosQRMESFYlShL5B1YHk04Ke
	 6Fpfwapz5JfayiGAghcHCJbO5pMZ3DyPk+VnZtc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfFRIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:06:48 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F0B20B1F;
        Tue, 18 Jun 2019 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560845207;
        bh=vmefZDb3xtY3+JowXEb+2DJa4rQS3eadY9mZe/G1U6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoktxTNdHtevrzP7U/eM2kWLQmPRycjEGRerlVkaqvp4TTfnrdiFaRNLQa0AgvIga
         nADj9NOwBH0xKjVZsYjDRMY2B9xPWle7eF11+UNxRYon2qznz49oG5ZXJ7oerxrN1i
         XupcfTaHmp3W5qNKdtqwQEkHwnIC0rBeeVikWRRY=
Date:   Tue, 18 Jun 2019 16:05:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx7d-zii-rpu2: Fix incorrrect
 'stdout-path'
Message-ID: <20190618080557.GK29881@dragon>
References: <20190614074348.17210-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614074348.17210-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:43:47AM -0700, Andrey Smirnov wrote:
> RPU2 uses UART2 as a serial console and UART1 is not used at all. Fix
> incorrrectly specified 'stdout-path' to reflect that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied both, thanks.
