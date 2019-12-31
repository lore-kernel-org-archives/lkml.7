Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F2C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF18206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLaPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 10:32:15 -0500
Received: from ms.lwn.net ([45.79.88.28]:36918 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaPcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:32:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B3758536;
        Tue, 31 Dec 2019 15:32:14 +0000 (UTC)
Date:   Tue, 31 Dec 2019 08:32:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 2/8] Documentation: nfsroot.txt: convert to ReST
Message-ID: <20191231083213.0786bda1@lwn.net>
In-Reply-To: <47e2ea6e-a808-5012-6f9a-8800fbd3be00@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
        <92be5a49b967ce35a305fc5ccfb3efea3f61a19a.1577681164.git.dwlsalmeida@gmail.com>
        <20191230121807.3a1f5f38@lwn.net>
        <47e2ea6e-a808-5012-6f9a-8800fbd3be00@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2019 01:08:11 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> Would you please rephrase this? My first language isn't English and I am 
> not sure I understood that.
> 
> > It's best in general to avoid refilling paragraphs so as to make it clear
> > what is being changed.  But we would also like to avoid creating such long
> > lines.  Perhaps an add-on patch refilling things would satisfy both
> > criteria here.  

Changing text in an existing paragraph can
result in line lengths that are inconsistent and ragged, leading to a less 
pleasant appearance
and the temptation to "refill" the paragraph so that the 
lines are all approximately equal in length.  The problem with yielding
to that temptation is that it messes up
the diff output so that you can no longer easily see the actual
text changes that were made.

Thus, when making such changes, it can be better to not refill the
paragraphs - as, indeed, you did not.  But if the result becomes too
difficult to read (as in, it creates lines that are waaaay to long), it
can be good to create a second patch that makes only the cosmetic changes
without any associated text changes.  I was suggesting doing that in this
case.

Does that help?

Thanks,

jon
