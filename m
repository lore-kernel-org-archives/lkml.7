Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610CA2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZZWD9OpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfH2NtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:49:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39093 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfH2NtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:49:07 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so4487172iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=ZZWD9OpNRL0XtYFi2lFZlHxSZinqyJ8TpyLRrYC9iPu82pocpeGILmNJueXE79tL46
         Hx3iIG3SHdJuf3SlJEy1VlbhChjRlBUg7MhHjF0H71LlBWYxfvIQWax+sVjsQt5WUM/v
         VduNLbytEHMvZQWgrRu0W2b2t0rKniNs6zLPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=Jz4dR4l5Cm7afUCyipz1Mgj0Obvqu5RRiWcPLNzOqb1moaWC9zahasKqllBSRcrtmW
         sSlhW0Cliiyuxy4nytDVtqHXKu2gIuV+kw6vNDD3Jy5Utbyq03cHdkvM6OzlW+j2w/D0
         /HPqp/NR925l2XGX+IGLsMOVDUuOpyk+z0trlgbPQ2d/YaNgCooukN5x+wirVBgeph1M
         eeyH/YqJrS11zwX9uhwWZ+/qOeQqLbjYL27JLyBGBb7NEJ95i4d+6/r3jMpLrLugRlHU
         dgV64/JlmSbAC53WtH5qe2WS3JVuUqaLg49xir9J46+0NSRIWTS+katMlFT05QBVktgU
         Q8Kw==
X-Gm-Message-State: APjAAAXtGVqDrd55m3LvDVm/tsV0EHaZkMPLt+XEVxaSPS8xcA6Ju/Ew
        bpVzeAFJCGp+FdQEVPoDjLY6/24gpD3eyw59lFmdDg==
X-Google-Smtp-Source: APXvYqzW2n25R0aKrJKpGkCfaBBX65DnLGmBlfFac1mmX3iIfD8YBhimr86nLnQnYes5p3+3pE+/AtLQSkscAssggNI=
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr11000610iob.285.1567086547127;
 Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829134104.23653-1-stefanha@redhat.com>
In-Reply-To: <20190829134104.23653-1-stefanha@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 15:48:56 +0200
Message-ID: <CAJfpegsMwGLryccnOR5a0RTFKjv3jH4g0DQt-HpkSQTwZgHyKw@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: add Documentation/filesystems/virtiofs.rst
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Add information about the new "virtiofs" file system.

Thanks, applied.

Miklos
