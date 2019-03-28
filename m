Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11049C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B5206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfC1Kna convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:43:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Kna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:43:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so14834068wro.5;
        Thu, 28 Mar 2019 03:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qwTvssPTiRp+U5Oa/ZCQnvAqCq6nQB6zPdi3aPfmbk4=;
        b=WuKXK+jqtbMxtiOU9gftoB6vxA40QALHBA57kep8yxdP5RN9LtbZMFhp+Z+oupKB0e
         t+Se3LLRbBXNeBVnGEZtgUopoch1gy0gaPYOJqI4rG1bx3j7JUFUeUl40F+X1toDArvp
         BhDH+vrkCJrZ0kqXeTlFI7UOiMovUGqPjlwZNeQI+OW9T0ahMtWT8uK2GQgiY5265vQC
         mf1vhK71QFjvpxPp2ZAjlqy64vK3zCV+t2VPi6VxrOa0WIHXAuLgv10ciEI4ohRXRAuQ
         N6cmTLT9FiCuhFORQvfXEzbCtzAxo1w6sk+ww85Lp8m7ma8NJbtGVByuWw5zY2SZ0A67
         tIlA==
X-Gm-Message-State: APjAAAUiECpIvWxpIcNaGFqnUdDHkHcnBy6he0k2lGAIj/1E2QXM54Mx
        SzDpzZeeAz0gdloy3Lnxv8KHGdh4cutRmn6XCU8=
X-Google-Smtp-Source: APXvYqy6w4rW/eaFtXPFnHEzWgeo8H0fMJUMgXDuD9e5YQtIfo/UMRW35uFcZPi3GzU+klSj9YkdQBwvgdzbCWpNztM=
X-Received: by 2002:adf:f64d:: with SMTP id x13mr27932229wrp.298.1553769807866;
 Thu, 28 Mar 2019 03:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373043876.7602.1318289599022013332.stgit@warthog.procyon.org.uk>
In-Reply-To: <155373043876.7602.1318289599022013332.stgit@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mina86@mina86.com>
Date:   Thu, 28 Mar 2019 10:43:16 +0000
Message-ID: <CA+pa1O16AXPBz0G3JKWcGo-ry4C=q_GgpwRpoR8NmHChzpuFtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 53/68] vfs: Convert functionfs to use the new mount API
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not familiar with the new mount API but the code looks reasonable to me:

Acked-by: Michal Nazarewicz <mina86@mina86.com>

On Wed, 27 Mar 2019 at 23:47, David Howells <dhowells@redhat.com> wrote:
> Convert the functionfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.

-- 
Best regards
ミハウ “𝓶𝓲𝓷𝓪86” ナザレヴイツ
«If at first you don’t succeed, give up skydiving»
