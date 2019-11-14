Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28F220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R+xEQD03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKNSSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58844 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfKNSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:35 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A02920B4901;
        Thu, 14 Nov 2019 10:18:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A02920B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573755514;
        bh=sd/+ILMW3HOqjjFdPZLW7teDwHtSzje14R12p9PHhCU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=R+xEQD03lHZZp9wEAvnUW+jsln5ODyo3ery21KtNljMyvzsUuif5WEEblErSAAgE4
         9q1azVU9c/JfGQQO1EeMKuEqjmw7JroeNynEbKdNdhNUb4racJb0BwsmMZQZjtYppu
         qpR1Mfp7la6gCUJxogsHk8xU4tujRYsuDpYaj/4U=
Subject: Re: [PATCH v7 4/5] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-5-nramas@linux.microsoft.com>
 <1573742237.4793.30.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1deec85d-78b1-0cf2-ec2c-7dacaa2c3672@linux.microsoft.com>
Date:   Thu, 14 Nov 2019 10:18:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573742237.4793.30.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2019 6:37 AM, Mimi Zohar wrote:
> Keyrings may be created by userspace with any name (e.g. foo, foobar,
> ...).  A keyring name might be a subset of another keyring name.  For
> example, with the policy "keyrings=foobar", keys being loaded on "foo"
> would also be measured.  Using strstr() will not achieve what is
> needed.
> 
> Mimi

Very good catch - I missed that :(

Will fix and send an update.

thanks,
  -lakshmi

