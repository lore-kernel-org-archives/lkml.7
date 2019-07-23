Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59393C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883222512
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563868258;
	bh=e+rfHbmA114ieNPtGenJSrIxHywXJvrFDJHEzofAoxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uh2vSsOrgwiBWPebNBlJeomtBEUuFPNmT0tdGToK/uXq3HZXGPjKF7E9HjLYZdUqY
	 MT6RgEHzitc7UgwKM8z2ptLL2HqE3rE3+XQe5pHdoQf0j0PmgjRrlFH5C9J7s4Wi2q
	 jSwMiviEMCpc/fcFUrHKVoSPkHrtQ3YgvCPjM4XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfGWHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfGWHu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:50:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7AA21BF6;
        Tue, 23 Jul 2019 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868255;
        bh=e+rfHbmA114ieNPtGenJSrIxHywXJvrFDJHEzofAoxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AX4LRyECbHjthQZF2SidTeakLLjEHNYQXP5KfxlgtUjJUJUIPsqSynsKl2W6SKHDP
         x5VsY3Jg8iJfAthV2EBLRWtPsw6DctewlCsozGMvjr+hMJQuaeFfiB9PLUkbbU1EzM
         mThb+Ms1uQEld/fZ0wBumCzlOW8Phk9lEN+Vfrik=
Date:   Tue, 23 Jul 2019 15:50:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, =kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com
Subject: Re: [PATCH v2 0/3] Add power domain range for MU13 side b /
 IRQSTR_DSP
Message-ID: <20190723075024.GL15632@dragon>
References: <20190718102519.31855-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718102519.31855-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 01:25:16PM +0300, Daniel Baluta wrote:
> This patch adds power domain range for MU13 side b and irqsteer in
> preparation for adding support for DSP <-> AP IPC communication.
> 
> Changes since v1:
> 	- fixed typo in patch 1/3 commit message
> 	- enhance commit message for patch 2/3 as per Aisheng's comments
> 	- only add PD range for mu 13 side B
> 	
> Daniel Baluta (3):
>   firmware: imx: scu-pd: Rename mu PD range to mu_a
>   firmware: imx: scu-pd: Add mu13 b side PD range
>   firmware: imx: scu-pd: Add IRQSTR_DSP PD range

Applied all, thanks.
