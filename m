Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5073CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A33023777
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHTIjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:39:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729273AbfHTIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:39:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7K8btc9003386
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 04:39:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugb2qecy7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 04:39:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Tue, 20 Aug 2019 09:39:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 09:39:09 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7K8d8Sc62587032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 08:39:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2BE2A405B;
        Tue, 20 Aug 2019 08:39:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31559A4062;
        Tue, 20 Aug 2019 08:39:05 +0000 (GMT)
Received: from oc3276512013.ibm.com (unknown [9.120.237.31])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 08:39:04 +0000 (GMT)
Subject: Re: [PATCH]Perf: Return error code for perf_session__new function on
 failure
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
References: <20190814092654.7781.81601.stgit@localhost.localdomain>
 <20190815125116.GG30356@krava>
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date:   Tue, 20 Aug 2019 14:09:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815125116.GG30356@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19082008-4275-0000-0000-0000035B02C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082008-4276-0000-0000-0000386D21ED
Message-Id: <aab6e549-38b3-b18a-003c-9d1d96d7617c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri Olsa,

Thanks for reviewing the patch..

working on your comments, will post new version ASAP.


On 15/08/19 6:21 PM, Jiri Olsa wrote:
> On Wed, Aug 14, 2019 at 03:02:18PM +0530, Mamatha Inamdar wrote:
>
> SNIP
>
>>   		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
>> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
>> index ddbcd59..dbc6dc2 100644
>> --- a/tools/perf/util/data-convert-bt.c
>> +++ b/tools/perf/util/data-convert-bt.c
>> @@ -1619,8 +1619,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>>   	err = -1;
>>   	/* perf.data session */
>>   	session = perf_session__new(&data, 0, &c.tool);
>> -	if (!session)
>> +	if (IS_ERR(session)) {
>> +		err = PTR_ERR(session);
>>   		goto free_writer;
>> +	}
>>   
>>   	if (c.queue_size) {
>>   		ordered_events__set_alloc_size(&session->ordered_events,
> I'm getting:
>
>    CC       util/data-convert-bt.o
> util/data-convert-bt.c: In function ‘bt_convert__perf2ctf’:
> util/data-convert-bt.c:1622:6: error: implicit declaration of function ‘IS_ERR’; did you mean ‘SIG_ERR’? [-Werror=implicit-function-declaration]
>   1622 |  if (IS_ERR(session)) {
>        |      ^~~~~~
>        |      SIG_ERR
> util/data-convert-bt.c:1622:6: error: nested extern declaration of ‘IS_ERR’ [-Werror=nested-externs]
> util/data-convert-bt.c:1623:9: error: implicit declaration of function ‘PTR_ERR’ [-Werror=implicit-function-declaration]
>   1623 |   err = PTR_ERR(session);
>
>
> jirka
>

