Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0833C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9F220678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578566381;
	bh=4zBOYHX6eeVFAgflBYqbR1VmzzyGdmrN6kkQCLA9ZYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbHHXi2TDPSA7EIy3QWnezcxR3l9ruZ977BUzmMpM+bj2nLENsPme1qpznOaAhcYd
	 5Lw5ZHyiMbgU0VFRlHticx6vNTjf1Ep43K4VHWx/+AOqPq22d8mcoxTo52V8VvshPu
	 nvl/woGLKZIoFfHeLATxK5wJJWdvdPHA8+GoVbDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgAIKjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgAIKjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:39:40 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8978520673;
        Thu,  9 Jan 2020 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578566378;
        bh=4zBOYHX6eeVFAgflBYqbR1VmzzyGdmrN6kkQCLA9ZYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PNDEIdtYgnGmThcdeExByKs/hjypEDmN5Nm9AV5zYqSDgsPT5G3thzCYKUnG9moj
         Sc+DZkCaq2t9A1e1A2cdzHdYX7DcbK8nECEqm4QHUrYVQfpQLBVbWXDQFSRK3INveM
         fxDu3mPK2XuZrUeklhIzw8FtOZ/wN0KmzgAgJYTc=
Date:   Thu, 9 Jan 2020 18:39:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx6: Remove incorrect power supply
 assignment
Message-ID: <20200109103929.GP4456@T480>
References: <1578562682-32548-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578562682-32548-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 05:38:02PM +0800, Anson Huang wrote:
> The vdd3p0 LDO's input should be from external USB VBUS directly, NOT
> PMIC's power supply, the vdd3p0 LDO's target output voltage can be
> controlled by SW, and it requires input voltage to be high enough, with
> incorrect power supply assigned, if the power supply's voltage is lower
> than the LDO target output voltage, it will return fail and skip the LDO
> voltage adjustment, so remove the power supply assignment for vdd3p0 to
> avoid such scenario.

I applied v1 patches with using this version of commit log.

Shawn
