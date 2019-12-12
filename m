Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE07C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D8B24653
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576117689;
	bh=8R0G/Esfz6f8bJ+iwK7FblzQL1UoNKf4MiHAgRE9+0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TAVd7ePtBdd6dgJ3ZsLL3IspWFRJNT1kXTQvwJHRwuSzxYyGMATzeq5nZAn/q2e1u
	 iO3fkGOV4be28jMMRSJSI7kBcbqtcVrcE6X/UBIzYv3/48SjX6SwXMRdbCiSOI664C
	 /79meUR6/I/YFif1T24VaC/J3+1B79JJo8PAwkVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfLLC2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfLLC2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:28:08 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DF1214D8;
        Thu, 12 Dec 2019 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576117687;
        bh=8R0G/Esfz6f8bJ+iwK7FblzQL1UoNKf4MiHAgRE9+0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt7W00WnaDy9m5HuLcdJ3XqiPEbbvySLRgsmCvk0EWwUKbhAb0JipINEMa3sEEJJp
         bH6irVb9sYpMvcKBCYu7VS3g5vAEwuz0hArcloZhz2grjnEoXF2O9kJguPw8kIia35
         4Cca307sb++iTEX0FkavYDJBGBcTmWnDFrYyezUU=
Date:   Thu, 12 Dec 2019 10:27:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: vf610-zii-scu4-aib: Use generic names
 for DT nodes
Message-ID: <20191212022753.GG15858@dragon>
References: <20191211140444.7076-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211140444.7076-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:04:43AM -0800, Andrey Smirnov wrote:
> The devicetree specification recommends using generic node names.
> 
> Some ZII dts files already follow such recommendation, but some don't,
> so use generic node names for consistency among the ZII dts files.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied both, thanks.
