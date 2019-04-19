Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A955C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14A205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfDSS6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:40270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfDSS6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7124E537;
        Fri, 19 Apr 2019 18:58:15 +0000 (UTC)
Date:   Fri, 19 Apr 2019 12:58:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     kernel-doc@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs/zh_CN: redirect CoC docs to Chinese version
Message-ID: <20190419125814.16c10ff2@lwn.net>
In-Reply-To: <20190416022825.187932-1-alex.shi@linux.alibaba.com>
References: <20190416022825.187932-1-alex.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 10:28:24 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> That gives more natural reading experience for Chinese.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

I've applied both of these, thanks.

jon
