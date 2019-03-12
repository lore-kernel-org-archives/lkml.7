Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLN6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:58:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:33652 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfCLN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:58:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8CF2A9AC;
        Tue, 12 Mar 2019 13:58:24 +0000 (UTC)
Date:   Tue, 12 Mar 2019 07:58:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/31] clean up and reorg Chinese kernel docs
Message-ID: <20190312075823.31240738@lwn.net>
In-Reply-To: <4e9fbf0d-cf9a-63a3-4e94-902b1ae5a6cf@linux.alibaba.com>
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
        <4e9fbf0d-cf9a-63a3-4e94-902b1ae5a6cf@linux.alibaba.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 12:06:45 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> This series is ok for pick up.

I'll get to it after the merge window, thanks.

One request: if you have to update and resend a patch set for any reason,
please update the version number.  I'll get the right "v4" set this time,
but one shouldn't count on that.

Thanks,

jon
