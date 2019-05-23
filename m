Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1782168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558616271;
	bh=n2HD38HB3q+Y8kJFu5cGX6+cefNnTTsnJb63xkKX4a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S3Dv1C5VeVAbDqEaHBrLNwin5Cb/Pajl5p9p9QH7m0dZQszPG5jaL/jZQ7+kzht70
	 ch7Cv02/rIro9lhXIGQ8/Mu2ORQHvcZk9I7v4YSEZd7WHae/8oMD0HkhoEj4N7CH7n
	 LscWX3Jw8fhKOQcIQQ+dcmvwrQe0ri5BkW3PK2R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfEWM5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:57:50 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0AA21019;
        Thu, 23 May 2019 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558616269;
        bh=n2HD38HB3q+Y8kJFu5cGX6+cefNnTTsnJb63xkKX4a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dd7qw7axTZDdNdm7tXyj7wmsn9NIoOhpxyQcmY2itZXmjqQf0Y2snsEsXsFjv+jf8
         ggIUdElMR9aKovX0ynkfujYKlTzqYtcW4gl6nZiPbXfBVEB48ClL02PktC0ZuO1X5q
         OzEgMbb4q9VB1ZqNktAJfa0ygKe7/o8rn9nmLmUQ=
Date:   Thu, 23 May 2019 20:56:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: vf610-zii-dev: Fix incorrect UART2 pin
 assignment
Message-ID: <20190523125651.GW9261@dragon>
References: <20190522072052.2829-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522072052.2829-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:20:51AM -0700, Andrey Smirnov wrote:
> UART2 is connected to PTD22/23, not PTD0/1. Fix corresponding pinmux
> node.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied both, thanks.
