Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCE920665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfHAOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:50:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40929 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbfHAOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:50:57 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so19743251iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7savY0c7+JGOmA2NlA8BiARX3PVTCTIKO8zHVT8vSM=;
        b=BF/v7dIn4MO6c1ut4kgugw4VIyy7y6sJ59ln2yH+/su9dYNS87wdzzJrYUE2p90OFV
         uuQsk/4Xp9fAFRcBFJ4LjwHJDx+5hCbOEKKP8UaLA2QkYLlEQpKppwPsPOQOsamwq1cN
         oCJyxHVTwBd5HV0sAr/XLu38Ce89ETVDLg27PfnlwpIopLNNB65JYSwLQaQD5gVEyBt4
         6W9LxgrzFK+ZLWF5cg0uY/pCy2HfTC8cgrRHvg3I2EboYFwhE+ojvGNBCGXtcsdTyQni
         9tpYakUYOdtVKCQhpNKYsOAvhkIeGhPpv9qDyk4bK6oyjqEak7BwNvqQZf8GlgRTic7a
         CrPA==
X-Gm-Message-State: APjAAAViP1FQ4lZtUQLb2wveuaFZ82nvpMODNWhrzMwnGJ5F+P0H+kKP
        FX8A6TYEYFuITVDvtlO78Y5kwA==
X-Google-Smtp-Source: APXvYqxHTry5UUfAb7cgGx9zI7Xh3k0+18Fdw/UHtFAIi4LO/jIGcXljs3Y8z7TlxQkRkyGtIJB0PQ==
X-Received: by 2002:a05:6638:38f:: with SMTP id y15mr78741440jap.143.1564671055956;
        Thu, 01 Aug 2019 07:50:55 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id n22sm114654228iob.37.2019.08.01.07.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:50:54 -0700 (PDT)
Date:   Thu, 1 Aug 2019 08:50:50 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Tzung-Bi Shih <tzungbi@google.com>, bleung@chromium.org,
        groeck@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating
 script
Message-ID: <20190801145050.GA154523@google.com>
References: <20190730134704.44515-1-tzungbi@google.com>
 <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
 <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
 <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
 <89aac768-b096-c51c-2ec7-5c135b089a31@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89aac768-b096-c51c-2ec7-5c135b089a31@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:30:53PM +0200, Enric Balletbo i Serra wrote:
 
> Got it. I don't think this is a "kernel" way to do it. Also, I don't see a big
> value on doing this.

Code generation sounds great, but it makes finding and looking at the
source file difficult unless you have a build. It also makes Go to
definition in my editor fail to find the symbols since they don't exist
in the source tree.
> 
> Note also that actually, we want:
> 
> - cros_ec_commands (kernel) sync with ec_commands (EC firmware)
> - cros_ec_commands (kernel) sync with cros_ec_trace (kernel)
> 
> Hopefully we will have all sync soon.

That would be great if you synced the commands from the EC firmware :)

Thanks
