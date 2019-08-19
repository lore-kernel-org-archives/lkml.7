Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09FBC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759812086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213149;
	bh=aI4h5jgSRa0L6ddhNg2BVSqd0twEs/eoHqAiNRbdoBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZmrUjPh//VqDsXB28dPDb6yxe9MNrAqQaAKTz69CNBqSuN3hjKLMcHrpO+rb8ORqf
	 2amP0bXFnScXsPSa9mNx/nHzTsZggmCWU5ks3JmlOPI+jN0rQYS0v0z/KXWFkSklmu
	 fupZmFtTe/fMzqiGezgTqb7KbVF0DG5V9eU//XiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfHSLM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSLM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:12:27 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A40B2085A;
        Mon, 19 Aug 2019 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213146;
        bh=aI4h5jgSRa0L6ddhNg2BVSqd0twEs/eoHqAiNRbdoBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQkgo4L5WDAVFnTgo3syjvzkgJgmvxZuXWGpcj9SpVvXVdffd6ugJVbwfKQLkkJcO
         /v6yN26zWAudS8h14xiMj41sPYePQxEuJP+SCWDkXqUh7bbNLSmgpTkIMShDuezOhJ
         Hk5x/RbVxzGkZwf5k1ejHwRB3uS+UVWbVPs94IdA=
Date:   Mon, 19 Aug 2019 13:12:14 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 04/21] ARM: dts: imx7-colibri: Add sleep mode to
 ethernet
Message-ID: <20190819111213.GN5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-5-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-5-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:19PM +0000, Philippe Schenker wrote:
> Add sleep pinmux to the fec so it can properly sleep.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

I did s/mode/pinctrl in subject and applied the patch.

Shawn
