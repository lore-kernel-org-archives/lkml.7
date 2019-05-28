Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7406C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFBB217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfE1Rr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:47:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Rrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:47:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7195E263975
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: replace strncpy() by strscpy()
Organization: Collabora
References: <20190527174733.GA29547@embeddedor>
Date:   Tue, 28 May 2019 13:47:49 -0400
In-Reply-To: <20190527174733.GA29547@embeddedor> (Gustavo A. R. Silva's
        message of "Mon, 27 May 2019 12:47:33 -0500")
Message-ID: <8536kympx6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> The strncpy() function is being deprecated. Replace it by the safer
> strscpy() and fix the following Coverity warning:
>
> "Calling strncpy with a maximum size argument of 12 bytes on destination
> array version_string of size 12 bytes might leave the destination string
> unterminated."
>
> Notice that, unlike strncpy(), strscpy() always null-terminates the
> destination string.
>

Thanks, I'll get this queued up.

-- 
Gabriel Krisman Bertazi
