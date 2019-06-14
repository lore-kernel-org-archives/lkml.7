Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C193C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfFNUnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:43:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:54248 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfFNUnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:43:46 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ABBEB740;
        Fri, 14 Jun 2019 20:43:45 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:43:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] Documentation: coresight: Update the generic device
 names
Message-ID: <20190614144344.24604b27@lwn.net>
In-Reply-To: <CANLsYkzEz6RvDQT-ua+NmV=H3y08TZUJ2RqutQCEXxpL+75_=g@mail.gmail.com>
References: <1560189762-5267-1-git-send-email-suzuki.poulose@arm.com>
        <CANLsYkzEz6RvDQT-ua+NmV=H3y08TZUJ2RqutQCEXxpL+75_=g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 09:57:57 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This looks goo do me.  Jonathan, if you prefer to handle this via your tree:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Otherwise I'll pick it up.

I've applied it, thanks.

jon
