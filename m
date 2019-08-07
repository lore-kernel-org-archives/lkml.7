Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4386C21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zb5v06q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfHGSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:16:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbfHGSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:16:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77I8p9N121028;
        Wed, 7 Aug 2019 18:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qUy+Piq0soREyTmDqskiTZ6eZZpy8mIoJ+kw4TC8U4w=;
 b=zb5v06q+FmOlPrWa1um3hNZ54Shva9teRJ1m9VNVayEIQVwoPM4hB2ozwy0Fap71CtFN
 l0je1YBhs7qE5VsmhSI7s0Qz5N27Vz/SwaUujniF7DbXWpuF20bM+y2wu0+yFdfzaLQz
 doUvr9/wtuNu4vVXekAqQTF+ED4sT3bHpJv+xNXChuoB6+Ne3hwtp+g4hmlTV+dhxe9K
 gBtPaktH6s4YaccaRm76jhEQ3HENu6qxWzGDzk3974dUUiphy30SNy2Bmca8qv5MqEfZ
 jx2tR/hPx/mepfE4bu0uBKKNyWcWxGRv+w648YP1CyoIYY432T1FkPs4Pum2Os9hbt30 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wrdyt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 18:15:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77I8Nrl063690;
        Wed, 7 Aug 2019 18:13:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u75bwpbav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 18:13:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x77IDbn5011913;
        Wed, 7 Aug 2019 18:13:38 GMT
Received: from dhcp-10-159-136-182.vpn.oracle.com (/10.159.136.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 11:13:37 -0700
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
 <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
 <20190729205138.689864d2@gandalf.local.home>
 <8e50d405-a4fb-fadf-509e-157b031d7542@oracle.com>
 <20190802134229.2a969047@gandalf.local.home>
 <291a12f6-e1eb-052e-0dd6-0e649dd4a752@oracle.com>
 <20190802164641.46416744@gandalf.local.home>
 <87e1a9b8-9f72-c240-9b9a-2d454046e2f3@oracle.com>
 <20190802172508.10e829d6@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <213c75dd-e5a7-4536-9c3f-89825278dcfb@oracle.com>
Date:   Wed, 7 Aug 2019 11:13:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802172508.10e829d6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 8/2/19 2:25 PM, Steven Rostedt wrote:
> On Fri, 2 Aug 2019 14:12:54 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Hi Steve,
>>
>> The first patch would be like a temporary fix in case we need more
>> changes to the patches that add the new function - trace_array_set_clr()
>> and unexport ftrace_set_clr_event() and might take some time. In which
>> case I think it would be good to have this in place (But, not part of
>> this series).
>>
>> If they all are to go in together as part of the same release ie if all
>> is good with the concerned patches (Patch 6 & Patch 7), then I think
>> having this patch would be meaningless.
> Can you just do this part of patch 6 instead?

Yes, will merge the two ie -

1)  Add 2 new functions - trace_array_set_clr_event(), trace_array_lookup()

2)  Unexport ftrace_set_clr_event.

into a single patch.


Thanks,

Divya

>
> +/**
> + * trace_array_set_clr_event - enable or disable an event for a trace array
> + * @system: system name to match (NULL for any system)
> + * @event: event name to match (NULL for all events, within system)
> + * @set: 1 to enable, 0 to disable
> + *
> + * This is a way for other parts of the kernel to enable or disable
> + * event recording to instances.
> + *
> + * Returns 0 on success, -EINVAL if the parameters do not match any
> + * registered events.
> + */
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set)
> +{
> +	if (!tr)
> +		return -ENOENT;
> +
> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
> +}
> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
> +
>
> -- Steve
