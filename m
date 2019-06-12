Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B7208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560319168;
	bh=y0GfY+y9VR7izi112hwbvMEf+VlmMN+F47SVGBkjEbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qbQA1H8Pij5+ibRCVaQohVA+pIt9pO5oa8iGcAWwNr2uiRwWFhUSydjk2M0dui7m/
	 TApuH7xAEbzH4L4unf743NEMMYcbIa5af+gR+AigJW1euT5iJjmXE5EVF6IerqdMeB
	 ulXRy/UUFSkXm45rnFEuoowlcVbHU2UkfW7MQSKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfFLF72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfFLF71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:59:27 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFE1B20874;
        Wed, 12 Jun 2019 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560319167;
        bh=y0GfY+y9VR7izi112hwbvMEf+VlmMN+F47SVGBkjEbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIodPh/U/eeUkTAxbwFMw2vdA5nsdog5wlLZQqt+gJP62mOqm3/DCWTBxbdkrCvtU
         rZa3nvMCzy307Z7COtGMYMRZimXotIp1CrrasZJdgvwXKAccXVioKlEugrtw7vo607
         fAdN3alVk+3Oj9JcWCNe95FGs0Q3Fs2SmS+K2sks=
Date:   Wed, 12 Jun 2019 13:58:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Fix CPU idle fail.
Message-ID: <20190612054716.GA11086@dragon>
References: <20190517045753.3709-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517045753.3709-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 12:57:53PM +0800, Ran Wang wrote:
> PSCI spec define 1st parameter's bit 16 of function CPU_SUSPEND to
> indicate CPU State Type: 0 for standby, 1 for power down. In this
> case, we want to select standby for CPU idle feature. But current
> setting wrongly select power down and cause CPU SUSPEND fail every
> time. Need this fix.
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
