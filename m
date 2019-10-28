Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF77CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204A520B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572251904;
	bh=iDlj1N5pY/4IkC0huCZ6VrSYnvV4S5FkKFE256YWrNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fJjLTfOcCLRcHVEW0OA0v60hsNCoO0shQOZyzDLr1jUW7Eh+6mkqIr3Bb4vv4FF/j
	 99auwq+c/IoCWQa1UOahGOwYZNOWpFUMIjqecTBEhZjS+w11fKeGM4BGYkX92YdToM
	 U1LSRVTl1hhgzVfsdl7QWy9OdiU6FWT0xWdZvyyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfJ1IiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfJ1IiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:38:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B45820717;
        Mon, 28 Oct 2019 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572251902;
        bh=iDlj1N5pY/4IkC0huCZ6VrSYnvV4S5FkKFE256YWrNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlaVlCOyd0ITuRjB0ReA+dQeZ4XPjTXCWZTqVydm8ymaGERKl9XppneYJq0X/aLFs
         Td/UhPUtZaCLxo9mxkNpa+G8PUbFhg1f+VKCm3XZiMVLDRsTajrkRmVXvlA5aRBL41
         UR/E/lXOBdMoyobWdRiiRHXTSR9+a853oWEkFP+0=
Date:   Mon, 28 Oct 2019 16:38:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.lezcano@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Remove duplicated machine
 compatible
Message-ID: <20191028083759.GU16985@dragon>
References: <1571812481-28308-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571812481-28308-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:34:40PM +0800, Anson Huang wrote:
> Machine compatible string normally is located in board DT, remove
> the duplicated one from SoC dtsi.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
