Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554749622;
	bh=blGY1qBPro1jw5Z5Gd58ZnDylLrpiIcmAONOcprkPwA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nYua5o7tF4bmH4GDuS2lrVDToDfl+Y854W381+yEbUxjUPSf5/3XvkoMHN86ZRImc
	 MwDSbiisSx3YdoIAOwZElMrOVBRaPBexf1uwEVnsYWIKEjW81pPzK+jRwJJeuNxjjP
	 PMOZHZCcv5oLiFNbaDqso1B+kAfMgM5m9z/43Vao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfDHSxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfDHSxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:53:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE03720857;
        Mon,  8 Apr 2019 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554749620;
        bh=blGY1qBPro1jw5Z5Gd58ZnDylLrpiIcmAONOcprkPwA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QhI6VJtnwwSxkcdT3KoRgIgFI+3uW+KQS80XJj1D5pkrixaLBe6/GzRJXJ7pFI9PY
         vb/DQ/SfT/aJSH+SYcbbTCsxJnWCGn08r86NLgKPOi33kceVjcovlYsCPvSa0ZAdgm
         kJzEsSeS8f4P9jUFv38cGwhlWseRrh4+fzd9lHc8=
Subject: Re: [PATCH kselftest-next] selftests: cgroup: fix cleanup path in
 test_memcg_subtree_control()
To:     Roman Gushchin <guroan@gmail.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>
References: <20190328025659.25684-1-guro@fb.com>
From:   shuah <shuah@kernel.org>
Message-ID: <32b7ae48-99dd-1261-4086-37d416ffcfd5@kernel.org>
Date:   Mon, 8 Apr 2019 12:53:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328025659.25684-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 8:56 PM, Roman Gushchin wrote:
> Dan reported, that cleanup path in test_memcg_subtree_control()
> triggers a static checker warning:
>    ./tools/testing/selftests/cgroup/test_memcontrol.c:76 \
>    test_memcg_subtree_control()
>    error: uninitialized symbol 'child2'.
> 
> Fix this by initializing child2 and parent2 variables and
> split the cleanup path into few stages.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>


 From and Signed-off don't match. Please fix it and resend the patch.

thanks,
-- Shuah

