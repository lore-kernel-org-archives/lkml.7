Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D51C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7F920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfC1Nsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:48:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42662 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Nsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:48:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so23073494qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxJN7KZwjVhlD5YYrY2vpnOhFwirNWBN0KoRPfbv1oA=;
        b=CR4k/2kjcp6C1Q3w+pt7h7hkkMlDUSZI+mzkZlJkyU6wO+nDQrzJDZwmxriIpl26D/
         qTo6Dr10PcAKomkJK8a3qzt+qQHPV4W0bsHfgj7nGlRVBFDcQ2FiOAZBY4kR+Is6Qc6D
         NA534Q8eTanOf2otMJSixTS+OFz9tmaV6Qkvph2RiYVn01ciznFSYkM7Y0E0wOxGAzVz
         cGLtW1WaedqZyOYJuKu4G9tmx7ugyTZAn+xUZstED1y3yIouNMBzTtngyDhT12uy8mVj
         5/wkJTSyz3+QY8SD2HCoIN9SO4By1elYMpbE9O4fQKrVcfUVWwNDVzTfa/0vn5KBBzKO
         aW2w==
X-Gm-Message-State: APjAAAWRfEdlo1Utq1BLcvT8W9xo+XzSsY3VjCAwcHM/1BHrJotS2IeW
        3ijp2WKyraPvohNmtBmySjhmbXMBCgTZCHM7gV1C9Q==
X-Google-Smtp-Source: APXvYqxxtUUeggX+Rr+Kux/XWonBUhWao+tAmjSQfuelhZfIIcR8635TCSKKd7xtBknqW1v24NJ02vRNuOpPC1+dR3E=
X-Received: by 2002:ac8:925:: with SMTP id t34mr20208494qth.30.1553780929640;
 Thu, 28 Mar 2019 06:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190327101848.25477-1-nsaenzjulienne@suse.de> <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 28 Mar 2019 14:48:38 +0100
Message-ID: <CAO-hwJLatVKwgevfdFk1Lqqpg3H7Oc28_VEkiyxPXne3fhSrqw@mail.gmail.com>
Subject: Re: [PATCH v4] HID: core: move Usage Page concatenation to Main item
To:     "Junge, Terry" <terry.junge@poly.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:27 AM Junge, Terry <terry.junge@poly.com> wrote:
>
> Hi Nicolas,
>
> V4 looks good to me.

Looks good to me too.

Terry, can I consider this as a formal Rev-by you?

Cheers,
Benjamin

>
> Thanks,
> Terry
>
> >-----Original Message-----
> >Subject: [PATCH v4] HID: core: move Usage Page concatenation to Main item
> >
