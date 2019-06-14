Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7121FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073F21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfFNOOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:14:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33978 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfFNOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:50 -0400
Received: from [IPv6:2804:431:d719:557a:d711:794d:1c68:5ed3] (unknown [IPv6:2804:431:d719:557a:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 37ECD2610F6;
        Fri, 14 Jun 2019 15:14:46 +0100 (BST)
Subject: Re: [PATCH 4/4] media: docs: create vimc documentation
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, helen.koike@collabora.com,
        kernel@collabora.com, lkcamp@lists.libreplanetbr.org,
        linux-kernel@vger.kernel.org
References: <20190613150616.19336-1-andrealmeid@collabora.com>
 <20190613150616.19336-5-andrealmeid@collabora.com>
 <4359daf5-4a0c-64b4-46ad-75eba4e9016f@xs4all.nl>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <244f7aaf-fc6c-8509-49d3-5b5d4ca067b9@collabora.com>
Date:   Fri, 14 Jun 2019 11:14:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4359daf5-4a0c-64b4-46ad-75eba4e9016f@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On 6/14/19 4:30 AM, Hans Verkuil wrote:
> Hi André,
>
> Thanks for working one this, very nice to have this documentation.
>
> Some comments below:
>
> [...]
>
> Regards,
>
> 	Hans
Thanks for the feedback! I saw that 1/4 and 2/4 already are at your [GIT
PULL v5.3], so my v2 should only have 3/4 and 4/4, right?

Thanks,
        André

