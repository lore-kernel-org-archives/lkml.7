Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C653C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A41206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555984382;
	bh=wdn2wFRo9UzdnjyXRcSwMtuIZH/c1TrlwnDfifISqbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DtgqILIqxDhQ+5Gd2FqtfHHfdE4f6+omlVb3QrjsDMuNECtwM0+NxqJo/Qd93VGIU
	 mYUipjvmTcb08jxZrWsB8onmU4HZ55jPxBOnCYINy5lnrcjQPXGtw+81YiW9+KDdRG
	 odLZpJbfURRhY5cFQtuS2KhdxIZEPNQLJhiSJ3UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfDWBxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfDWBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:53:00 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B801A206BA;
        Tue, 23 Apr 2019 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555984379;
        bh=wdn2wFRo9UzdnjyXRcSwMtuIZH/c1TrlwnDfifISqbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lR6hjoA0AAim+/cWSDSC8378FJCmkCzIzgVxYeDtIO3GKqnswESXSQQdDr8VyPNGH
         RUQNZB+R0hJhwkXD0VjygYzG9mmamEonAOFRL3iM9e5CpL2XWSxhNbGk2n/m/Fu9EO
         oq0THgoNHIi0yfWiU1b5FYHxuLQqVGXg4+KBzjL8=
Date:   Tue, 23 Apr 2019 09:52:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: imx7d-adc: Add
 #io-channel-cells to required
Message-ID: <20190423015240.GA16166@dragon>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414183403.21538-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:34:00AM -0700, Andrey Smirnov wrote:
> Add #io-channel-cells to list of required properties. Needed to be
> able to reference that node by phandle.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied, thanks.
