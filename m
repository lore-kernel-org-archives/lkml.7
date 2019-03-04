Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C12A21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551677656;
	bh=USy8jk1ELoDHhaPW3oVOInoK71M+Yok2MDMXGPHVToY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cx39S1o5uDl4RbYRoY2SvC2e2hlyTgKpamGnOr5EP5Ds2/4z0lvtdZANotrQO4sUX
	 jtqUkBbl9upN4k435ph+R6/Onxx8mOFqsZ0BISy8YNTQiRp24N6h52bnqzjyPItHQt
	 AJLOaNfMrgQgWpxor1pxGx6Q5mGbQzB9Lgo7cKfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCDFeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfCDFeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:34:14 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B964A20815;
        Mon,  4 Mar 2019 05:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551677653;
        bh=USy8jk1ELoDHhaPW3oVOInoK71M+Yok2MDMXGPHVToY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7lFYmU/c7zrbBZxw1yffWE7DrJd8saPS6p76ZpbUM9QcUDq6iI7x6DqGNU1R7wzq
         IX/P8kX7OLzWZYterQwjJvYYaWE2fzNyheshqNsb+wh1+Z64sco6qya/zK/4E4TSNF
         +84/6mdyU+QPT6H7a1GYKE0JW6zR9GYjGFMeJTVM=
Date:   Mon, 4 Mar 2019 13:33:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the
 cpu port
Message-ID: <20190304053311.GX26041@dragon>
References: <1551425202-8871-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551425202-8871-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 08:26:42AM +0100, Michal Vokáč wrote:
> Use rgmii-id phy mode for the CPU port (MAC0) of the QCA8334 switch
> to add delays to both Tx and Rx clock.
> 
> It worked with the rgmii mode before because the qca8k driver
> (incorrectly) enabled delays in that mode and rgmii-id was not
> implemented at all.
> 
> Commit 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")
> removed the delays from the RGMII mode and hence broke the networking.
> 
> To fix the problem, commit a968b5e9d587 ("net: dsa: qca8k: Enable delay
> for RGMII_ID mode") was introduced.
> 
> Now the correct phy mode is available so use it.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks.
