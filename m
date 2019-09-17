Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA04C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0043A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568742289;
	bh=rmRmKMiC7Jwj8yfhuFCSoJVXsZ08fImeo664CGFyUaE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=utdRKb9VBzudf95VbF064QiFpzkEo8jg4bqK1+MnwkFOqZp/O3yc7vcpqs62Fv7sq
	 a6TlundCJ3OWV2RHIfHa+QY5P7QpWsIKGGKzDkdCQ4yJrrDHNvTlMJLKw8bkxPxkwr
	 kFKd2LQLJfx00hOWnEXLRISMVD7zGIy9rjfO7/rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfIQRos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfIQRor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:44:47 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01D82067B;
        Tue, 17 Sep 2019 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568742287;
        bh=rmRmKMiC7Jwj8yfhuFCSoJVXsZ08fImeo664CGFyUaE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qOhJ2v1kVyQzl8n7cMLaWlxOMCKocjBJlN8KkKC9+rShAbOnKava+HFnv4/3Tn1P1
         nB+5+czK0DvAuAjdMDyYu/RHpBz9jXbQ1Ipju9rh7g3XnZblpuIsJh2ZTuMxfkxii5
         iOa1lfxOb3D8uj3xMejaM+tu32NjIWaMh6pAPKR0=
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
 <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
Date:   Tue, 17 Sep 2019 11:44:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/19 10:54 AM, Eugeniu Rosca wrote:
> Shuah,
> 
> On Tue, Sep 17, 2019 at 09:25:31AM -0600, shuah wrote:
> 
> [..]
> 
>> I want two patches and the first one with
>> Fixes tag.
> 

These two patches need to be separate. The first one is a fix and
the second is an enhancement.

Please send two patches - the first one with Fixes tag.

thanks,
-- Shuah

