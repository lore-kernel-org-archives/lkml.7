Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CBC21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553829257;
	bh=mFtUpawQFPC8ftrAq4HbbC7c/h3kT7ZdQajGihiev7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SfnZK0AYqBuQvyIOCes6z4Ch/XrGOGAHlBbhXIGebDsnUBjY7ueK8RaJIYmQhoSOC
	 4cZa47yc4aAdZow4eFqTcS4ZgO7bU97GfFunwUHrG+WfvxOC5lUHxuVETqWSw3RWUN
	 C1IAWvoIX00JRdCQgAX77xg1/HF59wOomuK+j3fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfC2DOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfC2DOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:14:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF232082F;
        Fri, 29 Mar 2019 03:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553829255;
        bh=mFtUpawQFPC8ftrAq4HbbC7c/h3kT7ZdQajGihiev7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+tcNJDOz3Do1l5ql9eab+fIE7fwG9M9EO6pW5G6Q/QFjluv7wXKxBfPkF8xmUzO5
         vnr7w/7AJHF7uCRMAKugWwO8f1OxivKYeN+VsYUClbm7LDQqAFkJigsJwyp3NnfXTq
         YOwSbfjFoIVUo4I1x/MTaSA/dQYfSZg6mh+ujB8w=
Date:   Fri, 29 Mar 2019 11:13:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add supported ZII VF610
 boards to DT schema
Message-ID: <20190329031330.GP12513@dragon>
References: <20190325182243.16788-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325182243.16788-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:22:41AM -0700, Andrey Smirnov wrote:
> Add already supported ZII VF610 boards to DT schema.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied all, thanks.
