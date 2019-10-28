Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE71208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572228359;
	bh=6hdy3rQOKam4pWNmszL+u1lRqhsEHCrSgiX4PtHv/fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fq3IsW5wJsiPGTTSQp3thw46RLEsu8r/z4Dnvo+mpjjq/pzooh727eJsiuAGcNbNM
	 atSUfGSw7vvryVWM2NNrZCOO0QKjAYv4mBnfW8IhuAckBydIO9HULz3Z2vy+JG2HRG
	 WX7UkOicawN1qf75ZWMicpeqccHBotCdE/A86qH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfJ1CF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfJ1CF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:05:58 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39E120717;
        Mon, 28 Oct 2019 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572228357;
        bh=6hdy3rQOKam4pWNmszL+u1lRqhsEHCrSgiX4PtHv/fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKK0027H3RuysXfge/j1k+t3rct1m6UTmWCRjnBkTpHbD4mHe7NYG0dsLKS0bCYiy
         7196sN1XyfGvE0/j3X1k2tPmNzfiQzqzRTA/KcTtoSZlzLUii2aUyMqU+rFyObtf37
         aSzxDcKtcZdTt7PtTawRTOhXqbByULn49zim9P5s=
Date:   Mon, 28 Oct 2019 10:05:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Enable the I2C3 bus on all board
 variants
Message-ID: <20191028020535.GD16985@dragon>
References: <1571233789-4491-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571233789-4491-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:49:49PM +0200, Michal Vokáč wrote:
> imx6dl-yapp4 Draco and Ursa boards use the I2C3 bus to control some
> external devices through the /dev files.
> 
> So enable the I2C3 bus on all board variants, not just on Hydra.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks.
