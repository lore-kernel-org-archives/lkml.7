Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A169DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675402184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552566290;
	bh=PEySUhCGRI9SHjvbv4DCnTlr5EEmTX90UTGq+72yL8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b/5CxVrqZHg/6jf0Rzq/QWc3OWfdMYyC/c6gUx7uiB9Mgza/k8e5r48pOyEfVV4NZ
	 trIBA8Z1roEoXY8dIo8AVIlcCtfQRJsIA893dzKn+U5ZpESIEnstQ/cWbqzrfO6yBq
	 8yTW0TZ9UttLSxQdVAuVrT08pZPCcj8Py7X5zVbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCNMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfCNMYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:24:48 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2ED82184C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552566287;
        bh=PEySUhCGRI9SHjvbv4DCnTlr5EEmTX90UTGq+72yL8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w6V6yDCVAW8bRRSji7ftgDoJWycYYubz05CELC7QTTzwsgul5H/G5TjVl9T5gyN33
         5HGbW8oV9IP/RQlAcIFVrjZlihUslowG0GEY7Mzz/D6aHOSYEuwVlbL5MlFAaZ//p0
         F0CDd0V/tJnuh3WRr9tVE8r/5qLdUJgvgQ0K/BQk=
Received: by mail-qt1-f180.google.com with SMTP id k2so5766871qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:24:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWpfLkSZHs2kV2Iq/wfdF63FbkLRc2M+qzkk30yRKNCS6kE6g2R
        AgXoSdPYt85rg4s2XEwCAnGv7wmIV2WHZBF131I=
X-Google-Smtp-Source: APXvYqxuxT+XAy16fC4NRGS20IxbVJ+buZlkBBcwTyUjqkd48DUT63tyelg71bznxDus1m2Z5jlOzrLmiM2gXJNlrss=
X-Received: by 2002:a0c:9891:: with SMTP id f17mr38601118qvd.113.1552566287000;
 Thu, 14 Mar 2019 05:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR12MB13437FB2B95FE8F4B3456B3ACB4B0@MWHPR12MB1343.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB13437FB2B95FE8F4B3456B3ACB4B0@MWHPR12MB1343.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 14 Mar 2019 08:24:36 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5_iaoe4Ovc0aZHEfwq=gCcFuQGYA+ZKwSXd-yiw72kbw@mail.gmail.com>
Message-ID: <CA+5PVA5_iaoe4Ovc0aZHEfwq=gCcFuQGYA+ZKwSXd-yiw72kbw@mail.gmail.com>
Subject: Re: pull request: linux-firmware: update cxgb4 firmware
To:     Vishal Kulkarni <vishal@chelsio.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        dt <dt@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:13 AM Vishal Kulkarni <vishal@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL:
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks,
> Vishal
>
> The following changes since commit efd2c1cc375cff1c17b4259d99a7fee240c3b510:
>
>   linux-firmware: Update firmware file for Intel Bluetooth 8265 (2019-03-13 08:55:45 -0400)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to 283373fa112403c08e54a65f2b467a137c032b79:
>
>   cxgb4: update firmware to revision 1.23.3.0 (2019-03-14 03:02:52 -0700)
>
> ----------------------------------------------------------------
> Vishal Kulkarni (1):
>
>       cxgb4: update firmware to revision 1.23.3.0

Pulled and pushed out.  Thanks.

josh
