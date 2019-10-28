Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BDCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E720B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572252130;
	bh=VHBaBmrmobgxunBw4GiqPhty21KBWr0wMzEozp9PbLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=auMCs9WOak1M4QZZ0IvgaSrxyLF1lKw+d72KZGM4ESnpiWhpSoWGwoJn4s8rU7jNT
	 F4p9F0pjQUj3gdNEX6zOAINDktCkHMOpNBWbtwb/8WvM1KgL8x7dsO8nCKaB0vSPy0
	 65BkIjGxL/ivYUv1TPQjeMoU5xPDZU998a2eK37U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfJ1ImJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfJ1ImJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:42:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BE720717;
        Mon, 28 Oct 2019 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572252128;
        bh=VHBaBmrmobgxunBw4GiqPhty21KBWr0wMzEozp9PbLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8pD3SNNE/tr0/anqxjmHrDa/yx+yeEP0+TGvePIHlpCUOHXTrOTqPT98JJeaVEEW
         uKN1ACoMTZ+OnG8fF9caSOiV/MeF6jPZuwENWRQ0r6f85agS65ajyKJRKrdzq+gq4G
         B8KvRY8wKAK9z6INjEmdy6tvHY1BVGQtOmFSakK0=
Date:   Mon, 28 Oct 2019 16:41:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] ARM: dts: imx6q: Add missing cooling device
 properties for CPUs
Message-ID: <20191028084148.GV16985@dragon>
References: <1571884465-19720-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571884465-19720-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:34:23AM +0800, Anson Huang wrote:
> The cooling device properties "#cooling-cells" should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in the
> CPU node it is trying to bring up, so that it can register a cooling
> device.
> 
> Add such missing properties.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
