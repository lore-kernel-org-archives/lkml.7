Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B64CECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7AD20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oj2M5fdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfJPCXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6gaGl4ZpC5LRRX8VCe49mQAXDRUM7YNegWSvt2a6Nw=; b=oj2M5fdiWUVpDzruitqkaKM6L
        PLKBc9Ih//6M4s43x3qh7GhD7w+5P0pYRFnOyYMTy3qHb2ltzB7C74PyOIO+2+iLRk4l6ordEuGGV
        ray5zedAvjAxHJlTZr4JChgVKPr1yP/pKs6IkWfS6PTRKh+EX4bd6MbxcWDBolXuil6uURtWFbRsE
        AkgrknERX5kOEP54gV+STCh/jVfAEHMHT/4CzRQt71A21rK+6CG6G0m4jVmYEdJlx9u4ay3qHSFfr
        WMjRe/NhU3AmMJvt7L6yvd1avTL0qHKYU3U6nZ/cK43GuROapC0ir7kDB0Y8NUU8PPqeqHFucmyCG
        YlQgfXRyw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKYyH-00068Z-PW; Wed, 16 Oct 2019 02:23:29 +0000
Subject: Re: [PATCH] :scripts: prune-kernel : prunning kernel generalize way
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfields@fieldses.org
References: <20191015145548.24165-1-unixbhaskar@gmail.com>
 <c075bcce-0d6d-abee-7fb5-80821f2ae3a2@infradead.org>
 <20191016013601.GA13621@Gentoo>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b6ad816a-c67e-f16c-3613-563a43b629ad@infradead.org>
Date:   Tue, 15 Oct 2019 19:23:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016013601.GA13621@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 6:36 PM, Bhaskar Chowdhury wrote:
> On 16:03 Tue 15 Oct 2019, Randy Dunlap wrote:
>> Subject: s/prunning/pruning/
>> Subject:  s/:scripts:/scripts:/
>>
>> On 10/15/19 7:55 AM, Bhaskar Chowdhury wrote:
>>> This patch will remove old kernels from system selective way.
>>
>>                                                 in a selective way.
>>
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>>  scripts/prune-kernel | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/scripts/prune-kernel b/scripts/prune-kernel
>>> index 74143f229f84..28fae6c91218 100755
>>> --- a/scripts/prune-kernel
>>> +++ b/scripts/prune-kernel
>>> @@ -33,7 +33,7 @@ printf "\t\n Enlist the installed kernels \n\n\n"
>>>  cd $boot_dir && pwd
>>>
>>>  #Bash experts not recomend to run ls inside script,but you can by running that too
>>> -# ls -1 vmlinuz-*
>>> +# ls -1 vmlinuz-*
>>>
>>>  #This is the recommended way , little complex but that's what people want to see!
>>>
>>> @@ -42,10 +42,10 @@ find $boot_dir -name "vmlinuz-*" -type f -print0 -exec ls -1 {} \;
>>>  printf "\n\n\n Well, we need to purge some kernel to gain some space.\n\n\n"
>>>
>>>
>>> -printf "Please give the kernel version to remove: %s"
>>> +printf "Please give the kernel version to remove: %s"
>>>  read kernel_version
>>>
>>> -remove_old_kernel
>>> +remove_old_kernel
>>>
>>>  printf "\n\n Remove associated modules too ... \n\n"
>>>
>>> @@ -54,7 +54,7 @@ cd $modules_dir && pwd
>>>  printf "\n\n\n Enlist the installed modules \n\n\n"
>>>
>>>  #This is (-1) minus one not l(el)
>>> -# ls -1
>>> +# ls -1
>>>
>>>  find $modules_dir -name "$kernel_version-*" -type f -print0 -exec ls -1 {} \;
>>>
>>> @@ -66,14 +66,14 @@ rm -rf $modules_version
>>>  printf "\n\n Done \n\n"
>>>
>>>  printf "\n\n Want to remove another?[Yn] : %s"
>>> -read response
>>> +read response
>>>
>>>
>>>  if [[ $response == "Y" ]]; then
>>> - printf "Please give another version to remove : %s"
>>> + printf "Please give another version to remove : %s"
>>>   read kernel_version
>>>
>>> -remove_old_kernel
>>> +remove_old_kernel
>>>
>>>  elif [[ $response == "n" ]]; then
>>>
>>> @@ -81,4 +81,4 @@ elif [[ $response == "n" ]]; then
>>>
>>>  fi
>>>
>>> -exit 0
>>> +exit 0
>>> -- 
>>> 2.21.0
>>>
>>
>> Trying to apply this patch with 'patch --verbose' says:
>>
>> checking file scripts/prune-kernel
>> Using Plan A...
>> Hunk #1 FAILED at 33.
>> Hunk #2 FAILED at 42.
>> Hunk #3 FAILED at 54.
>> Hunk #4 FAILED at 66.
>> Hunk #5 FAILED at 81.
>> 5 out of 5 hunks FAILED
>> Hmm...  Ignoring the trailing garbage.
>> done
>>
>>
>> Those + and - lines with the same content don't make any sense.
>>
>> And probably Cc: the author of the script:
>> J. Bruce Fields <bfields@fieldses.org>
>>
>> -- 
>> ~Randy
> 
> Thank you Randy, silly mistakes creeps in...my bad ...will correct that
> and resend.
> BTW I haven't found Bruce's name anywhere...where did you get it? Or did I
> miss the obvious??

It's in the git repository history for this file.

> Ran against get_maintainers and it only throw a open list , no other
> names.So kinda, stump by that.> Time to redo it again...huh


-- 
~Randy
