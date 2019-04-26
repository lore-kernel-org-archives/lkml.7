Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A70C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995D206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556277950;
	bh=FM/dpq7eHpddjL+UU71FES9tcXis3DA5rNdzoDEgfC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YFhBj9Sr5PEqw90dFoaXmioDsIYEm+ybW5WF1qLyZXnErDicQIHucIJcctnp2Vd+t
	 Zpzuvny6CyiQnoYMFcGbj+mxM2PUs+8sJgwIos/nxelIywn9ic0es1rEfsej4ldreW
	 ABwIe3cTeiJkcUmn+9ldlYOpbXME8JkUrdPsEbYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfDZLZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:25:49 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11316206A3;
        Fri, 26 Apr 2019 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556277948;
        bh=FM/dpq7eHpddjL+UU71FES9tcXis3DA5rNdzoDEgfC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA96xBN+K45tSdbEbual83mrFxpIpj6AY+ZIHBmYOV0F+1P1bdkYSMeJScbuiCyn1
         bjgwadamlZdaek0ezRplmF3iNcNBBEBIVVwCRWICel54ZpusZtIaQKzIEcpAzePKxZ
         YBuYYxTcHt+bYTVx07Gir5DPw3hlaWOdYUmY7aZI=
Date:   Fri, 26 Apr 2019 16:55:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: idma64: Move driver name to the header
Message-ID: <20190426112543.GS28103@vkoul-mobl>
References: <20190409150219.15094-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409150219.15094-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 18:02, Andy Shevchenko wrote:
> There are two drivers that are relying on the iDMA 64-bit driver name
> to match. Instead of duplicating string in both of them, dedicate
> a header file and share it between users.

Applied, thanks

-- 
~Vinod
