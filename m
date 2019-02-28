Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1513DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EBA218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="TGzOdsb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfB1KNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:13:43 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:54694 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfB1KNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:13:42 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id D4D80A06B5;
        Thu, 28 Feb 2019 11:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1551348819;
        bh=S3EAUusdAAUToBpdzwTGc+10+j8+TmmPzO2udeyoXqs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TGzOdsb/bPVr/rIZB9j977RpOo1lNPEvzonRrq1EEO5E09EYsgfYtPKBVKA4ULk0o
         mwWxIfIIGLnV2uvd6yX62HC8CxKM7Vz1fEv70detI7fEHQqPfXrLCtcpE+HQnCx61k
         De5NvwyszPvb0vA8hUfFQbJ4EhJZm8bUpo4DKqjQ=
Subject: Re: [PATCH v2 2/2] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
To:     pisa@cmp.felk.cvut.cz
Cc:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, wg@grandegger.com, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com,
        ondrej.ille@gmail.com
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
 <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <e0cbca72-d30a-c4e5-a935-30933a09ed5f@ysoft.com>
Date:   Thu, 28 Feb 2019 11:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 02. 19 18:26, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Ahoj Pavle,

I can not comment on the content of the binding but it is a good
practice to add at least a short description to each commit even
if it should be the subject said differently.

Anyway, hats off to all of you, great work!

Greetings back to my alma mater,
Michal

> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
