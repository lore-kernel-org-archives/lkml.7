Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D23DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FD20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qmJfh4Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfE1TnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:43:21 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:34117 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfE1TnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559072598; bh=w6k0dD47tzu5UpmkfuOe6IsbXwYp8rlq/74I9ihZD1E=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=qmJfh4NelmAJ/u8p5Sl54E+JmqVU+GdSIBHnoFDiD9GohDNIYVJTYu7KKBG4C7mkBLeFQUkXODla7pNxsMciBYcwq1t863wFOzLBL85xR2aioUtToSH7LK2q3xY9Q2uqvA9foPQ2yDqXux/ollt7CfrWiMvGZGYKT/rEt+DGRHHeHl/kFSC7N2NznGBqPRsq5ynsZEkImTwGD2Q+KgcCejBlZhnDnhvg1kxyDAtZcPjMmgJAoWUgMlBBJNHXRi9AJ3XnpPD9ecz84WA5SRDZkdXQjQ9Cau7PR6KImnBNQrOVF7nN2AHqIdGBrodnqq8Nna3WEuCcRxr7oSlJKj6P/A==
X-YMail-OSG: xxzWLUAVM1knO05hrAqfD.pFhLyJ5wdTfzdCut8NM7hYut8pXxAjscP3PCK1JHC
 pAJeOk0EId1MIDbLepT3OOvUWRhRswWXvZrBiLW2YpcNDtae2mtKC4GDbkzd9x5qMlSZKqVk1cHe
 79MgUNT6zlsrcNzoyLyfjKEizibPmmRyZIEMKQnRCpox57pP4Khc8.eORhJdhmHP1AJHpwqayz57
 hr81BcVzbp2VqhKO2ptHE0cFrbQnKTz1lWhNTTjqqsMe0SEko36VHemcuXtv96kABFRZi5.hoF7g
 vI6rIx7EMCeutuHjqba_.yZ85SZO24BqVptOrzYJt6n7w8OOmwR2UeuUi1PGpEU04iI0VjExb2_9
 2m_XqcuqAcgpIYKEyvK9z63VQm2YKqb9KF_BCpkeFftMBMimAMJABIfyn_3mRpbgYEMq6AVsghZG
 OArnS8Jcupl5wsXU1TBC9W.Gz16fmYuJ50PsbNfOn_Y3xst_6ykX_7BnLiiqNJ9ekqVqOW6ziG2k
 fnNoNTttFqCp2eanmfC1U9zu_2kteKaVQNE9Vy9l46T9m5Laiq.8KKzJcypgF1uFAS0UmdZJ5Lf5
 WHbynHRRTKTh13ye6j1zniPyBei8grYIjzxmU.AbixHd83AkKZArOI0XrZLhLF0N4RiBjXmsICGp
 FDe1P6Gm6391fkgmne0EraGUiKyjFMrwjzcHWYi4oa0MWRmdfF1WAkwmG_FWCzCycBJT9XoL9th9
 pqLGMSlLS_latLbCKyH43XQSVpnD93xVe.FFXwvoJbHfbdkzfHdJWOhL8vHhvReR3jnvgfYMSQ8w
 UBhIc9Z7OJ7EUPPTgOnKTV85NbhFbZAk5DPbWeSNcEneb3hP53rIfqpJ_9so8dnYjip4PEr1ptzt
 ZNw52nFoEV.FKc9i3hp9yFh2rYhogrgER6PJe1xHdDF4Xd2YcvB313nj1JvMcJW2kyL1CFR5n03F
 D74z3FJOeeGlShqbR.Ime1ehmL4ihQxmNHh8eMB.VQhygyT6cKAwaXvdQntp24pQbOtmSWwalx2S
 2ZCjnbj7Z8WDu2sldbhn3EdEkQv4InPJ8JLgSKfut7v57hOQ6rsUyrTwh6pwXmHNije9ZAqaTtHh
 zTZEzHIhkwP2qry1EJoIODoPgpqjj6ikWNLyNByV5TX1FcLabvlQ7dSaRWvnBkQMSdvZLoWn8eBq
 vNCbExVG9uhAMN53QTUiLMQMnU_HLqB0QTvCY9CaIYOBUWEtUkS7j6BC2r4d9ZD9JWLV37orIsZY
 Mhjt7puqhKZsye0cU.6qoNGB1nhMRIEpl4yAxxYMnvSYi6Ec3hnlg
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 19:43:18 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a1548a9f042941d1415b405d9e7b868;
          Tue, 28 May 2019 19:43:14 +0000 (UTC)
Subject: Re: [PULL] Smack: Restore the smackfsdef mount option
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com>
 <10710.1559070135@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6e061326-5feb-5471-c0c0-a364af5e82c3@schaufler-ca.com>
Date:   Tue, 28 May 2019 12:43:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <10710.1559070135@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2019 12:02 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> James, this is a repair for a regression introduced in 5.1.
>> It should be pulled for 5.2 and added to 5.1.
>>
>> The following changes since commit 619ae03e922b65a1a5d4269ceae1e9e13a0=
58d6b:
>>
>>   Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/cschaufler/next-smack.git smack-for-5.2-b
>>
>> for you to fetch changes up to a5765ce797070d046dc53ccceeb0ed304cb918e=
b:
>>
>>   Smack: Restore the smackfsdef mount option (2019-05-28 10:22:04 -070=
0)
> Can you hold this for the moment, please?

OK ...

> Note that there appears to be another problem by inspection of the code=
=2E  I
> think that smack_sb_eat_lsm_opts() strips the "smack" prefix off of the=

> options, whereas smack_fs_context_parse_param() does not.
>
> This means that there's no need to do this:
>
> 	 static const struct fs_parameter_spec smack_param_specs[] =3D {
> 	+	fsparam_string("fsdef",		Opt_fsdefault),
> 		fsparam_string("fsdefault",	Opt_fsdefault),
> 		fsparam_string("fsfloor",	Opt_fsfloor),
> 		fsparam_string("fshat",		Opt_fshat),
>
> but that all the option names in that table *do* need prefixing with "s=
mack".

I'm not sure I follow the logic, because "mount -o smackfsdefault=3DPop"
does what I would expect it to.

> The way you enter the LSM is going to depend on whether
> generic_parse_monolithic() is called.  You're only going to enter this =
way if
> mount(2) is the syscall of entry and the filesystem doesn't override th=
e
> ->parse_monolithic() option (none in the upstream kernel).

So you're saying that the code works for the mount(2) case,
but won't work for some other case? Are you planning a fix?
Will that fix include restoration of smackfsdef?

> David

