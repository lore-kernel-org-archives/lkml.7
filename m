Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF60C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A441B21835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569024822;
	bh=17JRz2amHdxSVooJ13gPyptXnx8eAB3apkUDMD7W4vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GYXIV1qvOaNLxTK+iE+2IGugoTjKCuAVaMBFQqY0tkxVhiJGsErDa3udgRGWyuWuB
	 oeMGGwwO3QFsnq5YS/4H4hZ9oTld2ZJkmH9G/VnxbR2SoDlRqNIlvbe7MlnrHwgdae
	 h/R7coykxTm48citpw4jg9LmPn1WXrBRJdJNsJ14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfIUANl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfIUANl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:13:41 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1C820C01;
        Sat, 21 Sep 2019 00:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569024820;
        bh=17JRz2amHdxSVooJ13gPyptXnx8eAB3apkUDMD7W4vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zrz20NN7PFy5ZN41xCLt4x7O4O9oeDirT1iTE0v4ix1M/eqKK/K6n9xtKke+NhQi5
         /CjnzAS03Lwaq/qIadmBqnYx8xzIEBNDNjXy6fGUElfwbGhcZ/b89kHAzvXvNkGAAX
         HHRialNwDAHXLcgewgKIGPYXNfy8dWIU0DG4fTTo=
Date:   Fri, 20 Sep 2019 17:13:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH v2] mm/oom_killer: Add task UID to info message
 on an oom kill
Message-Id: <20190920171340.7591fd2899a06b5e7c390b76@linux-foundation.org>
In-Reply-To: <20190613082318.GB9343@dhcp22.suse.cz>
References: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
        <20190613082318.GB9343@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 10:23:18 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 12-06-19 13:57:53, Joel Savitz wrote:
> > In the event of an oom kill, useful information about the killed
> > process is printed to dmesg. Users, especially system administrators,
> > will find it useful to immediately see the UID of the process.
> 
> Could you be more specific please? We already print uid when dumping
> eligible tasks so it is not overly hard to find that information in the
> oom report. Well, except when dumping of eligible tasks is disabled. Is
> this what you are after?
> 
> Please always be specific about usecases in the changelog. A terse
> statement that something is useful doesn't tell much very often.
> 

<crickets?>

I'll add this to the chagnelog:

: We already print uid when dumping eligible tasks so it is not overly hard
: to find that information in the oom report.  However this information is
: unavailable then dumping of eligible tasks is disabled.

