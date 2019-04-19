Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7980205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfDSSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:40188 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfDSSrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:47:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5E8EC2D0;
        Fri, 19 Apr 2019 18:47:01 +0000 (UTC)
Date:   Fri, 19 Apr 2019 12:47:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] docs: doc-guide: remove the extension from .rst
 files
Message-ID: <20190419124700.69f7e9b6@lwn.net>
In-Reply-To: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
References: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 07:30:51 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> On almost all places, we're including ReST files without the
> extension.
> 
> Let's remove the extension here as well, in order to use just
> one standard.
> 
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

I've applied this; I'll leave the hwmon one for Guenter.

Thanks,

jon
